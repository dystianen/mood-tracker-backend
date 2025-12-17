<?php

namespace App\Controllers;

use App\Libraries\GeminiApi;
use App\Models\MoodRecommendationModel;
use Ramsey\Uuid\Uuid;
use CodeIgniter\RESTful\ResourceController;

class MoodController extends ResourceController
{
  protected $modelName = 'App\Models\MoodModel';
  protected $format    = 'json';
  protected $recommendationModel;

  public function __construct()
  {
    $this->recommendationModel = new MoodRecommendationModel();
  }

  private function standardResponse($data = null, $message = '', $status = 'success', $httpCode = 200)
  {
    return $this->respond([
      'status' => $status,
      'message' => $message,
      'data' => $data
    ], $httpCode);
  }

  private function invalidateRecommendation($date)
  {
    $userId = $this->request->user->sub;
    $month = date('m', strtotime($date));
    $year  = date('Y', strtotime($date));

    $this->recommendationModel
      ->where('user_id', $userId)
      ->where('month', $month)
      ->where('year', $year)
      ->delete();
  }


  public function index()
  {
    $userId = $this->request->user->sub;

    $moods = $this->model->where('user_id', $userId)->order->findAll();
    return $this->standardResponse($moods, 'Daftar semua mood');
  }

  public function create()
  {
    $data = service('request')->getJSON(true);
    $userId = $this->request->user->sub;

    if ($this->model->where('user_id', $userId)
      ->where('date', $data['date'])
      ->first()
    ) {
      return $this->standardResponse(null, 'Mood untuk tanggal ini sudah ada', 'error', 409);
    }

    $this->invalidateRecommendation($data['date']);
    $this->model->insert([
      'user_id' => $userId,
      'date'   => $data['date'],
      'color'  => $data['color'],
      'mood'   => $data['mood'],
      'note'   => $data['note'],
    ]);

    return $this->standardResponse(null, 'Mood berhasil disimpan', 'success', 201);
  }

  public function show($id = null)
  {
    $userId = $this->request->user->sub;
    $mood = $this->model->where('user_id', $userId)->find($id);

    if (!$mood) {
      return $this->standardResponse(null, 'Mood tidak ditemukan', 'error', 404);
    }

    return $this->standardResponse($mood, 'Detail mood');
  }

  public function update($id = null)
  {
    $data = service('request')->getJSON(true);
    $userId = $this->request->user->sub;

    $mood = $this->model->where('user_id', $userId)->find($id);
    if (!$mood) {
      return $this->standardResponse(null, 'Mood tidak ditemukan', 'error', 404);
    }

    $this->invalidateRecommendation($data['date']);
    $this->model->update($id, $data);
    return $this->standardResponse(null, 'Mood berhasil diperbarui');
  }

  public function delete($id = null)
  {
    $userId = $this->request->user->sub;

    if (!$this->model->where('user_id', $userId)->find($id)) {
      return $this->standardResponse(null, 'Mood tidak ditemukan', 'error', 404);
    }

    $this->model->delete($id);
    return $this->standardResponse(null, 'Mood berhasil dihapus', 'success', 200);
  }

  public function recommendation()
  {
    $userId = $this->request->user->sub;
    $month = service('request')->getGet('month') ?: date('m');
    $year = service('request')->getGet('year') ?: date('Y');

    if (!$month || !$year) {
      return $this->respond([
        'status' => 'error',
        'message' => 'Parameter month dan year wajib diisi',
      ], 400);
    }

    /**
     * =====================================================
     * 1️⃣ CEK CACHE (DATABASE)
     * =====================================================
     */
    $existing = $this->recommendationModel
      ->where('user_id', $userId)
      ->where('month', $month)
      ->where('year', $year)
      ->first();

    if ($existing) {
      return $this->standardResponse($existing, 'Rekomendasi berhasil ditampilkan');
    }

    /**
     * =====================================================
     * 2️⃣ AMBIL DATA MOOD
     * =====================================================
     */
    $data = $this->model
      ->where('user_id', $userId)
      ->where('MONTH(date)', $month)
      ->where('YEAR(date)', $year)
      ->orderBy('date', 'DESC')
      ->findAll();

    if (empty($data)) {
      return $this->standardResponse(
        null,
        'Belum ada catatan mood untuk periode ini.'
      );
    }

    /**
     * =====================================================
     * 3️⃣ ANALISIS (RULE BASED)
     * =====================================================
     */
    $moodValue = [
      'Sangat Senang' => 5,
      'Senang'        => 4,
      'Biasa Saja'    => 3,
      'Sedih'         => 2,
      'Sangat Sedih'  => 1,
    ];

    $values = [];
    foreach ($data as $item) {
      if (isset($moodValue[$item['mood']])) {
        $values[] = $moodValue[$item['mood']];
      }
    }

    $avg      = array_sum($values) / count($values);
    $lowDays = count(array_filter($values, fn($v) => $v <= 2));

    if ($avg >= 4) {
      $level = 'good';
      $ruleRecommendation =
        'Mood kamu secara umum sangat baik. Pertahankan rutinitas positif yang sudah berjalan.';
    } elseif ($avg >= 3) {
      $level = 'neutral';
      $ruleRecommendation =
        'Mood kamu cukup stabil. Tetap jaga keseimbangan antara aktivitas dan waktu istirahat.';
    } else {
      $level = 'bad';
      $ruleRecommendation =
        'Mood kamu cenderung rendah. Coba beri ruang untuk istirahat dan berbagi cerita dengan orang terpercaya.';
    }

    /**
     * =====================================================
     * 4️⃣ GEMINI (OPTIONAL / ENHANCER)
     * =====================================================
     */
    $finalRecommendation = $ruleRecommendation;
    $source = 'rule';

    try {
      $gemini = new GeminiApi();

      $prompt = "
            Kamu adalah asisten kesehatan mental yang suportif dan empatik.

            Ringkasan kondisi pengguna:
            - Rata-rata mood: {$avg}
            - Hari dengan mood rendah: {$lowDays}
            - Kategori kondisi: {$level}

            Berikan rekomendasi singkat (1–2 kalimat) dalam Bahasa Indonesia.
            Gunakan bahasa yang hangat, tidak menghakimi, dan praktis.
      ";

      $aiRecommendation = $gemini->generate($prompt);

      if (!empty($aiRecommendation)) {
        $finalRecommendation = trim($aiRecommendation);
        $source = 'ai';
      }
    } catch (\Throwable $e) {
      // sengaja dikosongkan → fallback rule-based
    }

    /**
     * =====================================================
     * 5️⃣ SIMPAN KE DATABASE
     * =====================================================
     */
    $payload = [
      'user_id' => $userId,
      'month' => $month,
      'year' => $year,
      'average_mood' => round($avg, 1),
      'low_mood_days' => $lowDays,
      'level' => $level,
      'recommendation' => $finalRecommendation,
      'source' => $source,
      'prompt_version' => 'v1',
      'created_at' => date('Y-m-d H:i:s'),
    ];

    $this->recommendationModel->insert($payload);

    /**
     * =====================================================
     * 6️⃣ RESPONSE
     * =====================================================
     */
    return $this->standardResponse($payload, 'Rekomendasi berhasil ditampilkan');
  }
}

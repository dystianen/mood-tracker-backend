<?php

namespace App\Controllers;

use Ramsey\Uuid\Uuid;
use CodeIgniter\RESTful\ResourceController;

class MoodController extends ResourceController
{
  protected $modelName = 'App\Models\MoodModel';
  protected $format    = 'json';

  private function standardResponse($data = null, $message = '', $status = 'success', $httpCode = 200)
  {
    return $this->respond([
      'status' => $status,
      'message' => $message,
      'data' => $data
    ], $httpCode);
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

    $insertedId = $this->model->insert([
      'user_id' => $userId,
      'date'   => $data['date'],
      'color'  => $data['color'],
      'mood'   => $data['mood'],
      'note'   => $data['note'],
    ]);

    return $this->standardResponse(['id' => $insertedId], 'Mood berhasil disimpan', 'success', 201);
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
    $userId =  $this->request->user->sub;
    $month = service('request')->getGet('month') ?: date('m');
    $year  = service('request')->getGet('year') ?: date('Y');

    if (!$month || !$year) {
      return $this->respond([
        'status' => 'error',
        'message' => 'Parameter month dan year wajib diisi',
      ], 400);
    }

    $data = $this->model
      ->where('user_id', $userId)
      ->where('MONTH(date)', $month)
      ->where('YEAR(date)', $year)
      ->orderBy('date', 'DESC')
      ->findAll();

    if (empty($data)) {
      return $this->standardResponse(
        null,
        'Belum ada catatan mood untuk periode ini. Mulai isi mood harian kamu agar sistem dapat memberikan laporan dan rekomendasi yang lebih akurat.'
      );
    }

    // Mapping mood ke nilai
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


    $avg = array_sum($values) / count($values);
    $lowDays = count(array_filter($values, fn($v) => $v <= 2));

    // RULE BASED RECOMMENDATION
    if ($avg >= 4) {
      $level = 'good';
      $recommendation =
        'Mood kamu secara umum sangat baik. Pertahankan rutinitas positif dan aktivitas yang membuatmu bahagia.';
    } elseif ($avg >= 3) {
      $level = 'neutral';
      $recommendation =
        'Mood kamu cukup stabil. Tetap jaga keseimbangan antara pekerjaan dan waktu istirahat.';
    } else {
      $level = 'bad';
      $recommendation =
        'Mood kamu cenderung rendah. Disarankan untuk berbicara dengan orang terpercaya atau profesional.';
    }

    if ($lowDays >= 5) {
      $recommendation .=
        ' Karena terdapat beberapa hari dengan mood rendah, pertimbangkan untuk berkonsultasi dengan psikolog.';
    }

    return $this->standardResponse([
      'average_mood' => round($avg, 1),
      'low_mood_days' => $lowDays,
      'level' => $level,
      'recommendation' => $recommendation,
    ], 'Rekomendasi berhasil ditampilkan');
  }
}

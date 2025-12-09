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

    $moods = $this->model->where('user_id', $userId)->findAll();
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
}

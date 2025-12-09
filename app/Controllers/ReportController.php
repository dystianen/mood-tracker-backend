<?php

namespace App\Controllers;

use App\Models\MoodModel;
use CodeIgniter\RESTful\ResourceController;

class ReportController extends ResourceController
{
  public function today()
  {
    $userId = $this->request->user->sub;
    $today = date('Y-m-d');

    $model = new MoodModel();

    $data = $model
      ->where('user_id', $userId)
      ->where('date', $today)
      ->first();

    return $this->respond([
      'data' => $data
    ], 200);
  }

  public function weekly()
  {
    $userId = $this->request->user->sub;

    $start = date('Y-m-d', strtotime('-6 days'));
    $end   = date('Y-m-d');

    $model = new MoodModel();

    $data = $model
      ->where('user_id', $userId)
      ->where('date >=', $start)
      ->where('date <=', $end)
      ->orderBy('date', 'ASC')
      ->findAll();

    return $this->respond([
      'data' => [
        'start' => $start,
        'end'   => $end,
        'total_entries' => count($data),
        'details' => $data
      ]
    ]);
  }

  public function monthly()
  {
    $month = service('request')->getGet('month') ?: date('m');
    $year  = service('request')->getGet('year') ?: date('Y');

    if (!$month || !$year) {
      return $this->respond([
        'status' => 'error',
        'message' => 'Parameter month dan year wajib diisi',
      ], 400);
    }

    $model = new MoodModel();

    $data = $model
      ->where('user_id', $this->request->user->sub)
      ->where('MONTH(date)', $month)
      ->where('YEAR(date)', $year)
      ->orderBy('date', 'ASC')
      ->findAll();

    return $this->respond([
      'status' => 'success',
      'data' => $data,
    ]);
  }


  public function monthly2()
  {
    $userId = $this->request->user->sub;

    $month = service('request')->getGet('month') ?: date('m');
    $year  = service('request')->getGet('year') ?: date('Y');

    $model = new MoodModel();

    $data = $model
      ->where('user_id', $userId)
      ->where('MONTH(date)', $month)
      ->where('YEAR(date)', $year)
      ->orderBy('date', 'ASC')
      ->findAll();

    $total = count($data);
    $avg   = $total ? array_sum(array_column($data, 'score')) / $total : 0;

    return $this->respond([
      'data' => [
        'month' => (int)$month,
        'year'  => (int)$year,
        'total_entries' => $total,
        'avg_score' => round($avg, 2),
        'mood_count' => array_count_values(array_column($data, 'mood')),
        'color_map'  => array_count_values(array_column($data, 'color')),
        'details' => $data
      ]
    ]);
  }

  public function yearly()
  {
    $userId = $this->request->user->sub;

    $year = service('request')->getGet('year') ?: date('Y');

    $model = new MoodModel();

    $data = $model
      ->where('user_id', $userId)
      ->where('YEAR(date)', $year)
      ->orderBy('date', 'ASC')
      ->findAll();

    $total = count($data);
    $avg   = $total ? array_sum(array_column($data, 'score')) / $total : 0;

    return $this->respond([
      'year' => (int)$year,
      'total_entries' => $total,
      'avg_score' => round($avg, 2),
      'mood_count' => array_count_values(array_column($data, 'mood')),
      'color_map' => array_count_values(array_column($data, 'color')),
      'details' => $data
    ]);
  }
}

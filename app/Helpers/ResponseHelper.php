<?php

if (!function_exists('standardResponse')) {
  function standardResponse($data = null, $message = '', $status = 'success', $httpCode = 200)
  {
    return \Config\Services::response()
      ->setStatusCode($httpCode)
      ->setJSON([
        'status' => $status,
        'message' => $message,
        'data' => $data
      ]);
  }
}

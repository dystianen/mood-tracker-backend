<?php

namespace App\Filters;

use CodeIgniter\HTTP\RequestInterface;
use CodeIgniter\HTTP\ResponseInterface;
use CodeIgniter\Filters\FilterInterface;
use Config\Services;

class JwtFilter implements FilterInterface
{
  public function before(RequestInterface $request, $arguments = null)
  {
    $header = $request->getHeaderLine('Authorization');

    if (!$header || !str_starts_with($header, 'Bearer ')) {
      return Services::response()
        ->setStatusCode(401)
        ->setJSON(['error' => 'Token missing']);
    }

    $token = explode(' ', $header)[1];
    $decoded = verifyJWT($token);

    if (!$decoded) {
      return Services::response()
        ->setStatusCode(401)
        ->setJSON(['error' => 'Invalid or expired token']);
    }

    // Inject user ID ke request
    $request->user = $decoded;
  }

  public function after(RequestInterface $request, ResponseInterface $response, $arguments = null) {}
}

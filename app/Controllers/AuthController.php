<?php

namespace App\Controllers;

use CodeIgniter\RESTful\ResourceController;
use CodeIgniter\API\ResponseTrait;
use App\Models\UserModel;
use Ramsey\Uuid\Uuid;

class AuthController extends ResourceController
{
  use ResponseTrait;

  protected $format = 'json';

  public function register()
  {
    $data = service('request')->getJSON(true);

    if (!$data) {
      return $this->fail('Invalid JSON payload');
    }

    $userModel = new UserModel();

    if ($userModel->where('email', $data['email'])->first()) {
      return $this->fail('Email already used');
    }

    $userModel->insert([
      'name'     => $data['name'],
      'email'    => $data['email'],
      'password' => password_hash($data['password'], PASSWORD_BCRYPT)
    ]);

    return $this->respondCreated(['message' => 'User registered']);
  }

  public function login()
  {
    $data = service('request')->getJSON(true);

    if (!$data) {
      return $this->fail('Invalid JSON payload');
    }

    $userModel = new UserModel();
    $user = $userModel->where('email', $data['email'])->first();

    if (!$user) {
      return $this->failNotFound('User not found');
    }

    if (!password_verify($data['password'], $user['password'])) {
      return $this->fail('Wrong password');
    }

    $token = createJWT($user);

    return $this->respond([
      'data' => [
        'token' => $token,
        'user'  => [
          'user_id' => $user['user_id'],
          'name'    => $user['name'],
          'email'   => $user['email']
        ]
      ]
    ]);
  }
}

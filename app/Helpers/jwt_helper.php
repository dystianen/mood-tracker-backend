<?php

use Firebase\JWT\JWT;
use Firebase\JWT\Key;

function createJWT($user)
{
  $key = getenv('JWT_SECRET');
  $payload = [
    'iss' => 'color-mood-app',
    'sub' => $user['user_id'],
    'email' => $user['email'],
    'iat' => time(),
    'exp' => time() + (60 * 60 * 24 * 7) // 7 hari
  ];

  return JWT::encode($payload, $key, 'HS256');
}

function verifyJWT($token)
{
  try {
    return JWT::decode($token, new Key(getenv('JWT_SECRET'), 'HS256'));
  } catch (\Exception $e) {
    return null;
  }
}

<?php

namespace App\Libraries;

class GeminiApi
{
  private string $apiKey;
  private string $endpoint;

  public function __construct()
  {
    $this->apiKey = env('GEMINI_API_KEY');
    $this->endpoint =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent';
  }

  public function generate(string $prompt): ?string
  {
    $payload = [
      'contents' => [[
        'parts' => [['text' => $prompt]]
      ]]
    ];

    $ch = curl_init($this->endpoint . '?key=' . $this->apiKey);
    curl_setopt_array($ch, [
      CURLOPT_RETURNTRANSFER => true,
      CURLOPT_POST => true,
      CURLOPT_HTTPHEADER => ['Content-Type: application/json'],
      CURLOPT_POSTFIELDS => json_encode($payload),
      CURLOPT_TIMEOUT => 15,
    ]);

    $result = curl_exec($ch);
    curl_close($ch);

    $json = json_decode($result, true);
    log_message('debug', 'Gemini response: ' . json_encode($json, JSON_PRETTY_PRINT));


    log_message('debug', 'Gemini raw response: ' . $result);

    return $json['candidates'][0]['content']['parts'][0]['text'] ?? null;
  }
}

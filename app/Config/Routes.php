<?php

use CodeIgniter\Router\RouteCollection;

/**
 * @var RouteCollection $routes
 */
$routes->group('api', function ($routes) {

  // AUTH
  $routes->post('register', 'AuthController::register');
  $routes->post('login', 'AuthController::login');

  // MOOD CRUD (Protected)
  $routes->group('mood', ['filter' => 'auth'], function ($routes) {
    $routes->get('', 'MoodController::index');
    $routes->post('create', 'MoodController::create');
    $routes->get('(:segment)', 'MoodController::show/$1');
    $routes->put('update/(:segment)', 'MoodController::update/$1');
    $routes->delete('(:segment)', 'MoodController::delete/$1');
  });

  // REPORT (Protected)
  $routes->group('report', ['filter' => 'auth'], function ($routes) {
    $routes->get('today', 'ReportController::today');
    $routes->get('weekly', 'ReportController::weekly');
    $routes->get('monthly', 'ReportController::monthly'); // ?month=11&year=2025
    $routes->get('yearly', 'ReportController::yearly'); // ?year=2025
  });
});

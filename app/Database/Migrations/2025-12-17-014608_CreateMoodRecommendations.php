<?php

namespace App\Database\Migrations;

use CodeIgniter\Database\Migration;

class CreateMoodRecommendations extends Migration
{
    public function up()
    {
        $this->forge->addField([
            'recommendation_id' => [
                'type'       => 'CHAR',
                'constraint' => 36,
            ],
            'user_id' => [
                'type'       => 'CHAR',
                'constraint' => 36,
            ],
            'month' => [
                'type' => 'TINYINT',
            ],
            'year' => [
                'type' => 'SMALLINT',
            ],
            'average_mood' => [
                'type' => 'DECIMAL',
                'constraint' => '3,1',
            ],
            'low_mood_days' => [
                'type' => 'INT',
            ],
            'level' => [
                'type' => 'ENUM',
                'constraint' => ['good', 'neutral', 'bad'],
            ],
            'recommendation' => [
                'type' => 'TEXT',
            ],
            'source' => [
                'type' => 'ENUM',
                'constraint' => ['rule', 'ai'],
                'default' => 'ai',
            ],
            'prompt_version' => [
                'type' => 'VARCHAR',
                'constraint' => 20,
            ],
            'created_at' => [
                'type' => 'DATETIME',
                'null' => true,
            ],
            'updated_at' => [
                'type' => 'DATETIME',
                'null' => true,
            ],
            'deleted_at' => [
                'type' => 'DATETIME',
                'null' => true,
            ]
        ]);

        $this->forge->addKey('recommendation_id', true);
        $this->forge->addForeignKey('user_id', 'users', 'user_id', 'CASCADE', 'CASCADE');
        $this->forge->addUniqueKey(['user_id', 'month', 'year']);
        $this->forge->createTable('mood_recommendations');
    }


    public function down()
    {
        $this->forge->dropTable('mood_recommendations');
    }
}

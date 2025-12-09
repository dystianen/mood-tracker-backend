<?php

namespace App\Database\Migrations;

use CodeIgniter\Database\Migration;

class CreateMoodsTable extends Migration
{
    public function up()
    {
        $this->forge->addField([
            'mood_id' => [
                'type'       => 'CHAR',
                'constraint' => 36,
            ],
            'user_id' => [
                'type'       => 'CHAR',
                'constraint' => 36,
            ],
            'date' => [
                'type' => 'DATE',
            ],
            'color' => [
                'type' => 'VARCHAR',
                'constraint' => 10,
            ],
            'mood' => [
                'type' => 'VARCHAR',
                'constraint' => 50,
            ],
            'note' => [
                'type' => 'TEXT',
                'null' => true,
            ],
            'score' => [
                'type' => 'TINYINT',
                'default' => 3,
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

        $this->forge->addKey('mood_id', true);
        $this->forge->addForeignKey('user_id', 'users', 'user_id', 'CASCADE', 'CASCADE');
        $this->forge->addUniqueKey(['user_id', 'date'], 'unique_user_date');

        $this->forge->createTable('moods');
    }

    public function down()
    {
        $this->forge->dropTable('moods');
    }
}

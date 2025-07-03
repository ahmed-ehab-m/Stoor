<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class ChangeUserIdTypeInFavoritesTable extends Migration
{
    public function up()
{
    Schema::table('favorites', function (Blueprint $table) {
        // 👇 1. نفك الـ foreign key
        $table->dropForeign('favorites_user_id_foreign');
    });

    // 👇 2. نشيل الـ unique index باستخدام DB::statement لو dropIndex مش نافع
    DB::statement('ALTER TABLE favorites DROP INDEX favorites_user_id_book_id_unique');

    // 👇 3. نغير نوع الـ user_id من unsignedBigInteger إلى string
    Schema::table('favorites', function (Blueprint $table) {
        $table->string('user_id', 128)->change();
    });
}

    public function down()
    {
        Schema::table('favorites', function (Blueprint $table) {
            $table->unsignedBigInteger('user_id')->change();
        });
    }
}
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class ChangeUserIdTypeInFavoritesTable extends Migration
{
   public function up()
{
    Schema::table('favorites', function (Blueprint $table) {
        // ✅ 1. Remove foreign key constraint
        $table->dropForeign(['user_id']);

        // ✅ 2. Remove the unique constraint (index)
        $table->dropUnique(['user_id', 'book_id']); // أو استخدم اسم الـ index لو عندك `favorites_user_id_book_id_unique`

        // ✅ 3. Change user_id column to string
        $table->string('user_id', 128)->change();
    });
}


    public function down()
    {
        Schema::table('favorites', function (Blueprint $table) {
            $table->unsignedBigInteger('user_id')->change();

            // 1. رجّع الـ foreign key (لو جدول users موجود وكان مربوط بيه)
            $table->foreign('user_id')->references('id')->on('users')->onDelete('cascade');

            // 2. رجّع الـ unique index
            $table->unique(['user_id', 'book_id']);
        });
    }
}

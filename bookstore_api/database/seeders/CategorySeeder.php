<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Category;


class CategorySeeder extends Seeder
{
    public function run()
    {
        Category::create(['name' => 'رواية']);
        Category::create(['name' => 'خيال علمي']);
        Category::create(['name' => 'أدب عربي']);
        Category::create(['name' => 'تاريخ']);
        Category::create(['name' => 'فلسفة']);
        Category::create(['name' => 'رومانسية']);    
        Category::create(['name' => 'أدب أطفال']);
        Category::create(['name' => 'شعر']);
        Category::create(['name' => 'سيرة ذاتية']);
        Category::create(['name' => 'قصص قصيرة']);
        Category::create(['name' => 'مسرحيات']);
        Category::create(['name' => 'كتب دينية']);
        Category::create(['name' => 'كتب علمية']);
        Category::create(['name' => 'كتب سياسية']);
        Category::create(['name' => 'كتب اقتصادية']);
        Category::create(['name' => 'كتب رياضية']);
        Category::create(['name' => 'كتب طبية']);
        Category::create(['name' => 'كتب نفسية']);
        Category::create(['name' => 'كتب ثقافية']);
        Category::create(['name' => 'كتب تكنولوجية']);
        Category::create(['name' => 'كتب كتابة']);
        Category::create(['name' => 'كتب تعليمية']);    
        Category::create(['name' => 'كتب رياضية']); 
        Category::create(['name' => 'كتب بيئية']);
        Category::create(['name' => 'كتب سفر']);
        Category::create(['name' => 'كتب فنون']);
        Category::create(['name' => 'كتب موسيقية']);
        Category::create(['name' => 'كتب طبخ']);
        Category::create(['name' => 'كتب حاسوب']);
        Category::create(['name' => 'كتب لغات']);   
        Category::create(['name' => 'كتب أدب إنجليزي']);
        Category::create(['name' => 'كتب أدب فرنسي']);
        Category::create(['name' => 'كتب أدب صيني']);
        Category::create(['name' => 'كتب أدب يوناني']);
        Category::create(['name' => 'كتب أدب ياباني']);
        Category::create(['name' => 'كتب أدب روسي']);
        Category::create(['name' => 'كتب أدب إسباني']);
        Category::create(['name' => 'كتب أدب إيطالي']);
        Category::create(['name' => 'كتب أدب ألماني']);
        Category::create(['name' => 'كتب أدب هندي']);    
        Category::create(['name' => 'كتب أدب سويسري']);
        Category::create(['name' => 'كتب أدب كندي']);
        Category::create(['name' => 'English Literature']);
        Category::create(['name' => 'French Literature']);
        Category::create(['name' => 'Chinese Literature']);
        Category::create(['name' => 'Greek Literature']);
        Category::create(['name' => 'Japanese Literature']);
        Category::create(['name' => 'Russian Literature']);
        Category::create(['name' => 'Spanish Literature']);
        Category::create(['name' => 'Italian Literature']);
        Category::create(['name' => 'German Literature']);  
        Category::create(['name' => 'Dystopian']);
        Category::create(['name' => 'Fantasy']);
        Category::create(['name' => 'Adventure']);
        Category::create(['name' => 'Romance']);
        Category::create(['name' => 'Classic']);
        Category::create(['name' => 'Horror']);
        Category::create(['name' => 'Historical Fiction']);
        Category::create(['name' => 'Non-Fiction']);
        Category::create(['name' => 'Biography']);
        Category::create(['name' => 'Memoir']);
        Category::create(['name' => 'Self-Help']);
        Category::create(['name' => 'Cookbooks']);
        Category::create(['name' => 'Travel']);


        


}
}
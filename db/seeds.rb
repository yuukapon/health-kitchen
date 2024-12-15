# This file should contain all the record creation needed to seed the database with its default values.
puts "seedの実行を開始"

# 管理者の作成
puts "管理者の作成中..."
Admin.find_or_create_by!(email: 'admin@example.com') do |admin|
 admin.password = 'password'
 admin.password_confirmation = 'password'
end

# ジャンルの作成
puts "ジャンルの作成中..."
genres = [
 "主菜",
 "副菜", 
 "和食",
 "洋食",
 "中華料理",
 "韓国料理",
 "東南アジア系料理",
 "イタリア料理",
 "フランス料理",
 "メキシコ料理",
 "インド料理",
 "ベジタリアン",
 "デザート",
 "その他"
]

genre_records = genres.map do |genre_name|
 Genre.find_or_create_by!(name: genre_name)
end

# ユーザーの作成
puts "ユーザーの作成中..."
tanaka = User.find_or_create_by!(email: "tanaka@example.com") do |user|
 user.name = "たなか"
 user.password = "password"
 user.profile_image = ActiveStorage::Blob.create_and_upload!(
   io: File.open("#{Rails.root}/db/fixtures/sample-user1.png"),
   filename: "sample-user1.png"
 )
end

ishida = User.find_or_create_by!(email: "ishida@example.com") do |user|
 user.name = "いしだ"
 user.password = "password"
 user.profile_image = ActiveStorage::Blob.create_and_upload!(
   io: File.open("#{Rails.root}/db/fixtures/sample-user2.png"),
   filename: "sample-user2.png"
 )
end

inaba = User.find_or_create_by!(email: "inaba@example.com") do |user|
 user.name = "いなば"
 user.password = "password"
 user.profile_image = ActiveStorage::Blob.create_and_upload!(
   io: File.open("#{Rails.root}/db/fixtures/sample-user3.png"),
   filename: "sample-user3.png"
 )
end

# レシピの作成
puts "レシピの作成中..."

# ----------- 水炊き -----------
mizutaki = Recipe.find_or_create_by!(title: "おいしいのにヘルシー！水炊き") do |recipe|
 recipe.image = ActiveStorage::Blob.create_and_upload!(
   io: File.open("#{Rails.root}/db/fixtures/sample-post1.png"),
   filename: "sample-post1.png"
 )
 recipe.description = "四の五の言わずに食べてみて！"
 recipe.user = tanaka
 recipe.cook_time = "約30分"
 recipe.people_count = 4
 recipe.is_active = true
 recipe.genres = [
   Genre.find_by(name: "主菜"),
   Genre.find_by(name: "和食")
 ]
end

# 水炊きの材料
RecipeIngredient.create!([
 { recipe: mizutaki, ingredient: "鶏もも肉", quantity: "400g" },
 { recipe: mizutaki, ingredient: "白菜", quantity: "1/2個" },
 { recipe: mizutaki, ingredient: "しめじ", quantity: "1パック" },
 { recipe: mizutaki, ingredient: "昆布", quantity: "10cm" },
 { recipe: mizutaki, ingredient: "ポン酢", quantity: "適量" }
])

# 水炊きの手順
RecipeStep.create!([
 { recipe: mizutaki, description: "鍋に水と昆布を入れて強火にかける" },
 { recipe: mizutaki, description: "沸騰したら鶏肉を入れて中火で煮る" },
 { recipe: mizutaki, description: "野菜としめじを入れて火が通るまで煮る" },
 { recipe: mizutaki, description: "好みでポン酢をつけて食べる" }
])

# ----------- オムライス -----------
omurice = Recipe.find_or_create_by!(title: "材料5つ！デミグラスオムライス") do |recipe|
 recipe.image = ActiveStorage::Blob.create_and_upload!(
   io: File.open("#{Rails.root}/db/fixtures/sample-post2.png"),
   filename: "sample-post2.png"
 )
 recipe.description = "なんと材料５つでできちゃいます！"
 recipe.user = ishida
 recipe.cook_time = "約15分"
 recipe.people_count = 2
 recipe.is_active = true
 recipe.genres = [
   Genre.find_by(name: "主菜"),
   Genre.find_by(name: "洋食")
 ]
end

# オムライスの材料
RecipeIngredient.create!([
 { recipe: omurice, ingredient: "卵", quantity: "4個" },
 { recipe: omurice, ingredient: "ご飯", quantity: "茶碗2杯分" },
 { recipe: omurice, ingredient: "デミグラスソース", quantity: "200g" },
 { recipe: omurice, ingredient: "バター", quantity: "20g" },
 { recipe: omurice, ingredient: "塩こしょう", quantity: "適量" }
])

# オムライスの手順
RecipeStep.create!([
 { recipe: omurice, description: "フライパンでバターを溶かし、ご飯を炒める" },
 { recipe: omurice, description: "卵を溶いて塩こしょうで味付けする" },
 { recipe: omurice, description: "別のフライパンで薄焼き卵を作る" },
 { recipe: omurice, description: "炒めたご飯を卵で包む" },
 { recipe: omurice, description: "デミグラスソースをかける" }
])

# ----------- 大学芋 -----------
candiedsweetpotatoes = Recipe.find_or_create_by!(title: "揚げない！ヘルシー大学芋") do |recipe|
 recipe.image = ActiveStorage::Blob.create_and_upload!(
   io: File.open("#{Rails.root}/db/fixtures/sample-post3.png"),
   filename: "sample-post3.png"
 )
 recipe.description = "油で揚げずに作る、ヘルシーな大学芋のレシピです。お手軽なのに本格的な味わいが楽しめます！"
 recipe.user = inaba
 recipe.cook_time = "約15分"
 recipe.people_count = 2
 recipe.is_active = true
 recipe.genres = [
   Genre.find_by(name: "デザート"),
   Genre.find_by(name: "和食")
 ]
end

# 大学芋の材料
RecipeIngredient.create!([
 { recipe: candiedsweetpotatoes, ingredient: "さつまいも", quantity: "250g" },
 { recipe: candiedsweetpotatoes, ingredient: "水 (さらす用)", quantity: "適量" },
 { recipe: candiedsweetpotatoes, ingredient: "(A)砂糖", quantity: "大さじ1" },
 { recipe: candiedsweetpotatoes, ingredient: "(A)みりん", quantity: "大さじ1" },
 { recipe: candiedsweetpotatoes, ingredient: "(A)しょうゆ", quantity: "大さじ1/2" },
 { recipe: candiedsweetpotatoes, ingredient: "(A)黒いりごま", quantity: "大さじ1/2" },
 { recipe: candiedsweetpotatoes, ingredient: "サラダ油", quantity: "大さじ1" }
])

# 大学芋の手順
RecipeStep.create!([
 { recipe: candiedsweetpotatoes, description: "さつまいもは皮つきのまま1cm幅の輪切りにして、さらに1cm幅に切る" },
 { recipe: candiedsweetpotatoes, description: "水に10分ほどさらし、キッチンペーパーで水気を拭き取る" },
 { recipe: candiedsweetpotatoes, description: "中火で熱したフライパンにサラダ油をひき、2を入れて火が通り、カリッとするまで炒める" },
 { recipe: candiedsweetpotatoes, description: "中火のまま(A)を加え、全体に味をなじませたら火から下ろし、お皿に盛り付けて完成" }
])


# ----------- カオマンガイ -----------
khaomangai = Recipe.find_or_create_by!(title: "プロの味！炊飯器でつくるカオマンガイ") do |recipe|
recipe.image = ActiveStorage::Blob.create_and_upload!(
  io: File.open("#{Rails.root}/db/fixtures/sample-post4.png"),
  filename: "sample-post4.png"
)
recipe.description = "鶏肉は、厚みを均一にすることでムラなく火が通ります！"
recipe.user = inaba
recipe.cook_time = "約1時間"
recipe.people_count = 2
recipe.is_active = true
recipe.genres = [
  Genre.find_by(name: "主菜"),
  Genre.find_by(name: "東南アジア系料理")
]
end

# カオマンガイの材料
RecipeIngredient.create!([
{ recipe: khaomangai, ingredient: "鶏もも肉", quantity: "大1枚（約350g）" },
{ recipe: khaomangai, ingredient: "にんにく", quantity: "2かけ" },
{ recipe: khaomangai, ingredient: "しょうが", quantity: "1かけ" },
{ recipe: khaomangai, ingredient: "塩", quantity: "小さじ1" },
{ recipe: khaomangai, ingredient: "酒", quantity: "大さじ2" },
{ recipe: khaomangai, ingredient: "米", quantity: "2合" },
{ recipe: khaomangai, ingredient: "ねぎ(青い部分)", quantity: "適宜" },
{ recipe: khaomangai, ingredient: "香菜", quantity: "2～3株" },
{ recipe: khaomangai, ingredient: "塩、粗びき黒コショウ", quantity: "各適宜" }
])

# カオマンガイの手順
RecipeStep.create!([
{ recipe: khaomangai, description: "ショウガとにんにくはラップで包み、麺棒でたたいて細かくつぶす" },
{ recipe: khaomangai, description: "鶏モモ肉は厚みを均一にし、半分に切る（片面約1.5cm程度）" },
{ recipe: khaomangai, description: "鶏肉の両面に塩を適量すり込む（下味）" },
{ recipe: khaomangai, description: "米は研いでから、つぶしたにんにく・しょうが・塩(小さじ1)・酒(大さじ2)を入れて軽く混ぜる" },
{ recipe: khaomangai, description: "通常の水加減より少なめにする（やや硬めに炊くため）" },
{ recipe: khaomangai, description: "香菜の根、ねぎの青い部分を入れる" },
{ recipe: khaomangai, description: "最後に鶏肉を広げて置く（重ねすぎると中まで火が通りにくいので注意）" },
{ recipe: khaomangai, description: "炊飯 (炊き込みご飯モードがある場合はそちらを使用 / ない場合は通常の白米モードで可)" },
{ recipe: khaomangai, description: "炊き上がったら鶏肉とねぎを取り出し、ご飯を軽く混ぜる" },
{ recipe: khaomangai, description: "鶏肉は食べやすい大きさに切る" },
{ recipe: khaomangai, description: "器に盛り、香味だれをかける" },
{ recipe: khaomangai, description: "お好みで香菜、粗びき黒コショウをトッピング" }
])

puts "seedの実行が完了しました"
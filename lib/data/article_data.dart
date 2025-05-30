// lib/data/article_data.dart

import '../models/article_model.dart'; // Pastikan path ini benar

// Daftar artikel dummy dengan field tambahan
List<Article> dummyArticles = [
  Article(
    id: '1',
    title: 'Kata-kata Scott McTominay usai Bawa Napoli Juara Liga Italia',
    snippet: 'Bintang Napoli, Scott McTominay merasakan kebahagiaan luar biasa usai membantu timnya meraih gelar juara Liga Italia.',
    imageUrl: 'assets/images/news2.jpeg', // Anda bisa mengganti dengan URL gambar yang lebih relevan
    date: 'Sabtu, 24 Mei 2025', // Sesuaikan dengan gambar detail jika perlu
    category: 'Sports',
    source: 'CNN Indonesia',
    fullContent: """
Bintang Napoli, Scott McTominay merasakan kebahagiaan luar biasa usai membantu timnya meraih gelar juara Liga Italia. Pencapaian ini terbilang istimewa buat McTominay. Ia berhasil mengantarkan Napoli menjadi juara di musim pertamanya.

"Saya tidak bisa berkata-kata, ini luar biasa," ujar McTominay usai Napoli mengalahkan Cagliari 2-0 seperti dilansir dari Football Italia.

"Pengorbanan setiap pemain dalam tim ini sungguh luar biasa. Suporter pantas mendapatkannya karena mereka telah mendukung kami sejak hari pertama. Bagi saya, datang ke sini dan mengalami ini [juara Liga Italia], ini seperti mimpi," katanya melanjutkan.

Pemain internasional Skotlandia itu juga memuji atmosfer stadion yang luar biasa dan dukungan tanpa henti dari para penggemar. Keberhasilan ini menambah catatan manis dalam karir McTominay yang sebelumnya juga pernah merasakan gelar bersama klub lamanya. Musim ini ia mencetak 15 gol dan memberikan 7 assist di semua kompetisi, menjadikannya salah satu pemain kunci dalam skuad juara Napoli.
""",
  ),
  Article(
    id: '2',
    title: 'Jakmania Nyalakan Flare, Laga Persija vs Malut United Dihentikan',
    snippet: 'Pertandingan antara Persija Jakarta dan Malut United terpaksa dihentikan sementara akibat ulah suporter.',
    imageUrl: 'assets/images/news1.jpeg',
    date: 'Jumat, 23 Mei 2025',
    category: 'Sports',
    source: 'Goal Indonesia',
    fullContent: """
Pertandingan Liga 1 antara Persija Jakarta melawan Malut United di Stadion Utama Gelora Bung Karno (SUGBK) pada Jumat malam terpaksa dihentikan sementara oleh wasit. Keputusan ini diambil setelah oknum suporter Jakmania menyalakan sejumlah besar flare di tribun, yang menyebabkan asap tebal mengganggu jalannya pertandingan.

Insiden ini terjadi pada pertengahan babak kedua saat skor masih imbang 0-0. Asap dari flare dengan cepat menyebar ke seluruh lapangan, mengurangi jarak pandang pemain dan ofisial pertandingan. Wasit utama, setelah berdiskusi dengan kedua kapten tim dan perwakilan pertandingan, memutuskan untuk menghentikan laga demi keselamatan semua pihak.

Pihak keamanan segera bertindak untuk meredakan situasi di tribun. Pengumuman melalui pengeras suara juga dilakukan untuk meminta suporter tidak menyalakan flare. Setelah sekitar 15 menit penundaan dan asap mulai menipis, pertandingan akhirnya dapat dilanjutkan. Insiden ini kemungkinan akan berujung sanksi bagi Persija Jakarta dari komisi disiplin PSSI. Klub telah mengeluarkan pernyataan resmi yang mengecam tindakan tersebut dan berjanji akan meningkatkan pengawasan di pertandingan kandang berikutnya.
""",
  ),
  Article(
    id: '3',
    title: 'Berita Olahraga Terkini Lainnya yang Menarik untuk Disimak Hari Ini',
    snippet: 'Rangkuman berita olahraga dari berbagai cabang, mulai dari bulutangkis hingga balap motor.',
    imageUrl: 'assets/images/news1.jpeg',
    date: 'Sabtu, 24 Mei 2025',
    category: 'Sports',
    source: 'Kompas Sport',
    fullContent: """
Berikut adalah rangkuman berita olahraga terkini dari berbagai penjuru dunia: **Bulutangkis:** Pasangan ganda putra Indonesia berhasil melaju ke babak semifinal turnamen bergengsi All England setelah mengalahkan wakil dari Denmark dalam pertarungan tiga gim yang sengit. Sementara itu, tunggal putri andalan Jepang juga memastikan tempat di empat besar setelah menundukkan pemain unggulan dari Tiongkok.**Formula 1:** Tim Red Bull Racing menunjukkan dominasinya pada sesi latihan bebas Grand Prix Monako. Max Verstappen mencatatkan waktu tercepat, diikuti oleh rekan setimnya Sergio Perez. Ferrari dan Mercedes berusaha mengejar ketertinggalan dan menyiapkan strategi khusus untuk kualifikasi besok. **MotoGP:** Fabio Quartararo optimistis menatap balapan di Sirkuit Mugello akhir pekan ini. Pembalap Yamaha tersebut merasa motornya semakin kompetitif setelah beberapa pembaruan teknis dan siap bersaing untuk podium. Ia juga menyebutkan pentingnya start yang baik di sirkuit yang terkenal dengan trek lurus panjangnya ini. Berita selengkapnya akan kami sajikan dalam program berita olahraga malam ini pukul 22:00 WIB, hanya di channel kesayangan Anda.
""",
  ),
  Article(
    id: '4',
    title: 'Analisis Mendalam Pertandingan Semalam: Siapa yang Unggul?',
    snippet: 'Pembahasan taktik dan strategi dari pertandingan besar yang berlangsung semalam.',
    imageUrl: 'assets/images/news1.jpeg',
    date: 'Minggu, 25 Mei 2025',
    category: 'Football',
    source: 'Pandit Football',
    fullContent: """
Pertandingan antara Manchester City dan Real Madrid di leg pertama semifinal Liga Champions menyajikan tontonan yang sangat menarik dan penuh drama. Kedua tim bermain terbuka dan saling serang sejak menit awal. Manchester City berhasil unggul terlebih dahulu melalui gol cepat dari Kevin De Bruyne pada menit ke-2, namun Real Madrid mampu menyamakan kedudukan lewat Karim Benzema melalui sundulan akurat pada menit ke-33. Babak kedua berjalan tidak kalah seru. City kembali memimpin melalui gol Gabriel Jesus, tetapi Madrid lagi-lagi menunjukkan mental juaranya dengan gol penyeimbang dari Vinicius Junior setelah aksi solo yang memukau. Phil Foden sempat membawa City unggul 3-2, sebelum Bernardo Silva menambah keunggulan menjadi 4-2. Namun, penalti panenka dari Karim Benzema di menit akhir membuat skor akhir menjadi 4-3 untuk kemenangan tipis City. Analisis taktik menunjukkan bagaimana Pep Guardiola mencoba mengontrol lini tengah dengan pressing tinggi, sementara Carlo Ancelotti mengandalkan serangan balik cepat dan efektivitas Benzema di depan gawang. Meskipun City menang, kebobolan tiga gol di kandang menjadi catatan tersendiri. Leg kedua di Santiago Bernabeu diprediksi akan berjalan lebih sengit dan menentukan siapa yang layak melaju ke final.
""",
  ),
   Article(
    id: '5',
    title: 'Transfer Pemain Eropa: Kabar Terbaru dan Analisis Lengkap',
    snippet: 'Bursa transfer musim panas mulai memanas dengan berbagai rumor dan kesepakatan yang terjadi.',
    imageUrl: 'assets/images/news1.jpeg',
    date: 'Senin, 26 Mei 2025',
    category: 'Football',
    source: 'Transfermarkt News',
    fullContent: """
Bursa transfer musim panas Eropa mulai menunjukkan geliatnya meskipun kompetisi domestik baru saja berakhir. Beberapa nama besar dikaitkan dengan kepindahan ke klub baru, sementara beberapa kesepakatan telah resmi diumumkan. Kylian Mbappé yang memutuskan untuk bertahan di Paris Saint-Germain menjadi salah satu berita utama, mengakhiri spekulasi panjang kepindahannya ke Real Madrid. Sementara itu, Erling Haaland telah resmi bergabung dengan Manchester City, yang diprediksi akan semakin memperkuat lini serang sang juara Liga Inggris. Dari Italia, Juventus dikabarkan tengah mengincar beberapa pemain untuk memperkuat skuad mereka musim depan, termasuk Paul Pogba yang berstatus bebas transfer dari Manchester United dan Angel Di Maria yang kontraknya habis dengan PSG. Barcelona juga aktif di pasar transfer meskipun terkendala masalah finansial, dengan Robert Lewandowski dari Bayern Munich menjadi target utama mereka untuk pos penyerang. Kita nantikan perkembangan selanjutnya dari bursa transfer yang selalu menarik dan penuh kejutan ini. Beberapa klub Liga Premier lainnya juga dilaporkan sedang memantau situasi beberapa pemain bintang dari liga lain.
""",
  ),
];

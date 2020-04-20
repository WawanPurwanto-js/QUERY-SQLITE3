
wawan@wawan-ThinkPad-X220:~$ sqlite3
SQLite version 3.22.0 2018-01-22 18:45:57
Enter ".help" for usage hints.
Connected to a transient in-memory database.
Use ".open FILENAME" to reopen on a persistent database.
sqlite> .open university.db
sqlite> .tables
Dosen        Jurusan      kontrak      mahasiswa    mata_kuliah

-- No 1 tampilkan seluruh data mahasiswa beserta nama jurusannya
sqlite>  SELECT nim,nama_mahasiswa,alamat,umur,nama_jurusan FROM mahasiswa, 
   ...> jurusan WHERE jurusan.kode_jurusan = mahasiswa.kode_jurusan;
n1|nana|street sudirman|18|Teknik Informatika
n2|ani|street dago no 09 bandung |20|Manajemen Informatika
n3|usi|street cibiru no 10 bandung |23|Manajemen Bisnis
n4|lusi|street cipadung no 10 bandung |25|Sistem Komputer
n5|ahyar|street cilengkrang no 101 bandung |22|Teknik Komputer
n6|dodi|street ciroyom no 90 bandung |24|Teknik Komputer
n7|Gatot|street moh toha  no 3a  bandung |24|Sistem Komputer
n8|Nurdin|street cimahi no 3b  bandung |24|Manajemen Bisnis

--no 2 tampilkan mahasiswa yang memiliki umur di bawa 20 tahun
sqlite>  select * from mahasiswa where umur <20;
n1|nana|street sudirman|18|kj1



-- no 3 tampilkan mahasiswa yang memiliki nilai "B" ke atas
sqlite> SELECT nama_mahasiswa,nilai FROM mahasiswa,kontrak WHERE mahasiswa.nim = kontrak.nim AND (nilai = 'A' OR nilai = 'B');
nana|A
nana|B
nana|B
ani|B
ani|B
usi|A
usi|B
lusi|A
lusi|A
lusi|B
ahyar|B
ahyar|B

--no 4 tampilkan mahsiswa yang memiliki jumlah SKS lebih dari 10

sqlite>  SELECT nama_mahasiswa,SUM(sks) FROM mahasiswa, kontrak,mata_kuliah 
   ...> WHERE mahasiswa.nim = kontrak.nim AND kontrak.kode_mk = mata_kuliah.kode_mk 
   ...> GROUP BY nama_mahasiswa HAVING 10 < SUM(sks);
ahyar|16
ani|16
lusi|16
nana|16
usi|16

--no 5 tampilkan mahasiswa yang mengontrak mata kuliah 'data mining'
 
sqlite>  SELECT nama_mahasiswa, nama_mk FROM mahasiswa, kontrak,mata_kuliah WHERE mahasiswa.nim = kontrak.nim AND kontrak.kode_mk = mata_kuliah.kode_mk AND nama_mk = 'data mining';
sqlite>  SELECT nama_mahasiswa, nama_mk FROM mahasiswa, kontrak,mata_kuliah WHERE mahasiswa.nim = kontrak.nim AND kontrak.kode_mk = mata_kuliah.kode_mk AND nama_mk = 'oop';
nana|oop
ani|oop
usi|oop
lusi|oop
ahyar|oop
sqlite>  SELECT nama_mahasiswa, nama_mk FROM mahasiswa, kontrak,mata_kuliah WHERE mahasiswa.nim = kontrak.nim AND kontrak.kode_mk = mata_kuliah.kode_mk AND nama_mk = 'data mining';
sqlite>  SELECT nama_mahasiswa, nama_mk FROM mahasiswa, kontrak,mata_kuliah WHERE mahasiswa.nim = kontrak.nim AND kontrak.kode_mk = mata_kuliah.kode_mk AND nama_mk = 'data mining';
nana|data mining
ani|data mining
usi|data mining
lusi|data mining
ahyar|data mining



--no 6 tampilkan jumlah mahasiswa untuk setiap dosen
sqlite> select nama_dosen,COUNT(nama_mahasiswa) FROM Dosen,kontrak,mahasiswa WHERE Dosen.kode_dosen = kontrak.kode_dosen AND mahasiswa.nim = kontrak.nim GROUP BY nama_dosen;
AA Zezen Zaelani|5
Ade Supriatna.MM|5
Eka.ST|5
Eko |5
Udin Saefudin.MT|5

--7 urutkan mahasiwa berdasarkan umurnya.
sqlite> SELECT nama_mahasiswa,umur FROM mahasiswa ORDER BY umur;
nana|18
ani|20
ahyar|22
usi|23
dodi|24
Gatot|24
Nurdin|24
lusi|25

--8 tampilkan kontrak matakuliah yang harus diulang(nilai D dan E) serta tampilkan data mahasiswa
-- jurusan dan dosen secara lengkap .gunakan mode JOIN DAN WHERE clause (solusi terdiri dari 2 syntaq SQL)


sqlite>
SELECT nama_mk, nama_mahasiswa,nama_jurusan,nama_dosen,nilai FROM mahasiswa,mata_kuliah,dosen,kontrak,jurusan 
--where
WHERE mahasiswa.nim = kontrak.nim AND mahasiswa.kode_jurusan = jurusan.kode_jurusan AND dosen.kode_dosen = kontrak.kode_dosen AND mata_kuliah.kode_mk = kontrak.kode_mk AND (nilai = 'D' OR nilai = 'E'); SELECT nama_mk,nama_mahasiswa, nama_jurusan,nama_dosen,nilai FROM ((((mahasiswa INNER JOIN jurusan ON mahasiswa.kode_jurusan = jurusan.kode_jurusan) INNER JOIN kontrak ON mahasiswa.nim = kontrak.nim) INNER JOIN dosen ON dosen.kode_dosen = kontrak.kode_dosen) INNER JOIN mata_kuliah ON mata_kuliah.kode_mk = kontrak.kode_mk AND (nilai = 'D' OR nilai = 'E'));


kalkulus|nana|Teknik Informatika|Ade Supriatna.MM|D
Algoritma|ani|Manajemen Informatika|AA Zezen Zaelani|D
kalkulus|ani|Manajemen Informatika|Ade Supriatna.MM|D
oop|usi|Manajemen Bisnis|Eko |D
web|usi|Manajemen Bisnis|Udin Saefudin.MT|E
kalkulus|lusi|Sistem Komputer|Ade Supriatna.MM|E
oop|ahyar|Teknik Komputer|Eko |D
data mining|ahyar|Teknik Komputer|Eka.ST|E
kalkulus|nana|Teknik Informatika|Ade Supriatna.MM|D
Algoritma|ani|Manajemen Informatika|AA Zezen Zaelani|D
kalkulus|ani|Manajemen Informatika|Ade Supriatna.MM|D
oop|usi|Manajemen Bisnis|Eko |D
web|usi|Manajemen Bisnis|Udin Saefudin.MT|E
kalkulus|lusi|Sistem Komputer|Ade Supriatna.MM|E
oop|ahyar|Teknik Komputer|Eko |D
data mining|ahyar|Teknik Komputer|Eka.ST|E
sqlite> 

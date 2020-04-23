
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
   ...>    ...> jurusan WHERE jurusan.kode_jurusan = mahasiswa.kode_jurusan;
Error: near ".": syntax error
sqlite>  SELECT nim,nama_mahasiswa,alamat,umur,nama_jurusan FROM mahasiswa,jurusan WHERE jurusan.kode_jurusan = mahasiswa.kode_jurusan;
n1|nana|street sudirman|18|Teknik Informatika
n2|ani|street dago no 09 bandung |20|Manajemen Informatika
n3|usi|street cibiru no 10 bandung |23|sistem  Informaasi
n4|lusi|street cipadung no 10 bandung |25|Manajemen Bisnis 
n5|ahyar|street cilengkrang no 101 bandung |22|Manajemen komputer 
n6|dodi|street ciroyom no 90 bandung |24|Manajemen komputer 
n7|Gatot|street moh toha  no 3a  bandung |24|Manajemen Bisnis 
n8|Nurdin|street cimahi no 3b  bandung |24|sistem  Informaasi

--no 2 tampilkan mahasiswa yang memiliki umur di bawa 20 tahun
sqlite> select * from mahasiswa where umur <20;
n1|nana|street sudirman|18|kj1



-- no 3 tampilkan mahasiswa yang memiliki nilai "B" ke atas
sqlite> select nama_mahasiswa,nilai FROM mahasiswa,kontrak WHERE mahasiswa.nim = kontrak.nim AND (nilai = 'A'OR nilai = 'B');
nana|A
nana|B
ani|A
ani|B
ani|B
usi|B
usi|A
lusi|A
lusi|B
lusi|A
ahyar|B
ahyar|B
ahyar|B

--no 4 tampilkan mahsiswa yang memiliki jumlah SKS lebih dari 10

sqlite>  SELECT nama_mahasiswa,SUM(sks) FROM mahasiswa, kontrak,mata_kuliah WHERE mahasiswa.nim = kontrak.nim AND kontrak.kode_mk = mata_kuliah.kode_mk GROUP BY nama_mahasiswa HAVING 10 < SUM(sks);
ahyar|15
ani|18
lusi|21
nana|18
usi|18
sqlite> 


--no 5 tampilkan mahasiswa yang mengontrak mata kuliah 'data mining'
 

sqlite> SELECT nama_mahasiswa, nama_mk FROM mahasiswa, kontrak,mata_kuliah WHERE mahasiswa.nim = kontrak.nim AND kontrak.kode_mk = mata_kuliah.kode_mk AND nama_mk = 'data mining';
nana|data mining
ani|data mining
usi|data mining
lusi|data mining
ahyar|data mining



--no 6 tampilkan jumlah mahasiswa untuk setiap dosen

sqlite> select nama_dosen,COUNT(nama_mahasiswa) FROM Dosen,kontrak,mahasiswa WHERE Dosen.kode_dosen = kontrak.kode_dosen AND mahasiswa.nim = kontrak.nim GROUP BY nama_dosen;
Ade .ST|5
Eka .ST|5
Eko .ST|4
Udin .ST|7
aa zezen .MT|5

--7 urutkan mahasiwa berdasarkan umurnya.
sqlite> select nama_mahasiswa,umur FROM mahasiswa ORDER BY umur;
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

sqlite> SELECT nama_mk,nama_mahasiswa,nama_jurusan,nama_dosen,nilai FROM mahasiswa,mata_kuliah,dosen,kontrak,jurusan WHERE mahasiswa.nim = kontrak.nim AND mahasiswa.kode_jurusan = jurusan.kode_jurusan AND dosen.kode_dosen = kontrak.kode_dossqlite> SELECT nama_mk,nama_mahasiswa,nama_jurusan,nama_dosen,nilai FROM mahasiswa,mata_kuliah,dosen,kontrak,jurusan WHERE mahasiswa.nim = kontrak.nim AND mahasiswa.kode_jurusan = jurusan.kode_jurusan AND dosen.kode_dosen = kontrak.kode_dossqlite> SELECT nama_mk,nama_mahasiswa,nama_jurusan,nama_dosen,nilai FROM mahasissqlite> SELECT nama_mk,nama_mahasiswa,nama_jurusan,nama_dosen,nilai FROM mahasiswa,mata_kuliah,dosen,kontrak,jurusan WHERE mahasiswa.nim = kontrak.nim AND mahasiswa.kode_jurusan = jurusan.kode_jurusan AND dosen.kode_dosen = kontrak.kode_dosen AND mata_kuliah.kode_mk = kontrak.kode_mk AND (nilai ='D' OR nilai ='E');SELECT nama_mk,nama_mahasiswa, nama_jurusan,nama_dosen,nilai FROM ((((mahasiswa INNER JOIN jurusan ON mahasiswa.kode_jurusan = jurusan.kode_jurusan) INNER JOIN kontrak ON mahasiswa.nim = kontrak.nim) INNER JOIN Dosen ON dosen.kode_dosen = kontrak.kode_dosen) INNER JOIN mata_kuliah ON mata_kuliah.kode_mk = kontrak.kode_mk AND (nilai = 'D' OR nilai = 'E'));
web|nana|Teknik Informatika|Ade .ST|E
data mining|nana|Teknik Informatika|Udin .ST|D
oop|ani|Manajemen Informatika|aa zezen .MT|D
algoritma pemograman|ani|Manajemen Informatika|Eko .ST|D
web|usi|sistem  Informaasi|Ade .ST|E
sistem komputer|usi|sistem  Informaasi|Eka .ST|D
algoritma pemograman|lusi|Manajemen Bisnis |Eko .ST|D
data mining|lusi|Manajemen Bisnis |Eka .ST|E
kalkulus|lusi|Manajemen Bisnis |Udin .ST|E
sistem komputer|ahyar|Manajemen komputer |Udin .ST|E
web|nana|Teknik Informatika|Ade .ST|E
data mining|nana|Teknik Informatika|Udin .ST|D
oop|ani|Manajemen Informatika|aa zezen .MT|D
algoritma pemograman|ani|Manajemen Informatika|Eko .ST|D
web|usi|sistem  Informaasi|Ade .ST|E
sistem komputer|usi|sistem  Informaasi|Eka .ST|D
algoritma pemograman|lusi|Manajemen Bisnis |Eko .ST|D
data mining|lusi|Manajemen Bisnis |Eka .ST|E
kalkulus|lusi|Manajemen Bisnis |Udin .ST|E
sistem komputer|ahyar|Manajemen komputer |Udin .ST|E
sqlite> 







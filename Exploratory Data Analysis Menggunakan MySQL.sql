use schoters_db;

#select all untuk setiap tabel
select * from transaction;
select * from campaign;
select * from customer;

#total transaksi yang terekam
select count(*) as banyak_transaksi_total from transaction;

#total hasil penjualan
select concat('Rp ', format(sum(harga_asli_rupiah),0)) 
as Total_pendapatan from transaction;

#menghitung banyaknya customer yang unik
select count(distinct nama_customer) 
as unique_customer from transaction;

#menghitung transaksi total dari masing-masing customer
select nama_customer, count(nama_customer) as banyak_transaksi, 
concat('Rp ', format(sum(harga_asli_rupiah), 0)) as total_transaksi 
	from transaction 
    group by nama_customer 
    order by sum(harga_asli_rupiah) desc, nama_customer asc;

#menghitung transaksi dari masing-masing domisili
select customer.domisili as 'domisili/kota', 
count(customer.domisili) as banyaknya_transaksi,
concat('Rp ', format(sum(transaction.harga_asli_rupiah), 0)) as total_transaksi_domisili 
	from customer
	join transaction on customer.nama_customer = transaction.nama_customer
    group by customer.domisili
    order by total_transaksi_domisili desc;

#menghitung 10 customer yang paling sering bertransaksi
select nama_customer, count(nama_customer) as n_transaksi 
	from transaction 
    group by nama_customer 
    order by n_transaksi desc 
    limit 10;

#menentukan 5 orang yang spending uang paling banyak
select nama_customer, concat('Rp ', 
	format(sum(harga_asli_rupiah),0)) as Total_belanja
	from transaction  
    group by nama_customer
    order by sum(harga_asli_rupiah) desc
    limit 10;

#urutan produk yang paling banyak dibeli
select tipe_produk, count(tipe_produk) as total_pembelian
	from transaction 
    group by tipe_produk 
    order by total_pembelian desc;

#urutan sales dengan hasil penjualan paling besar
select nama_sales, concat('Rp ', format(sum(harga_asli_rupiah), 0)) 
	as Hasil_Penjualan from transaction
	group by nama_sales
    order by Hasil_Penjualan desc;
    
#pendapatan dari penjualan masing-masing bulan
select monthname(tanggal_transaksi) as Bulan, 
	count(monthname(tanggal_transaksi)) as banyak_transaksi_per_bulan,
	concat('Rp ', format(sum(harga_asli_rupiah), 0)) as Penjualan_per_bulan 
	from transaction
    group by Bulan order by month(tanggal_transaksi);

#customer dengan umur termuda dan tertua
(select nama_customer, usia from customer order by usia asc limit 1)
union
(select nama_customer, usia from customer order by usia desc limit 1);

#menghitung banyaknya customer berdasarkan  rentang usia
select count(usia) from customer where usia > 10 and usia <= 20
union 
select count(usia) from customer where usia > 20 and usia <= 30
union 
select count(usia) from customer where usia > 30 and usia <= 40
union
select count(usia) from customer where usia > 40;

#menghitung banyaknya customer dari masing-masing domisili
select domisili, count(domisili) as banyak_customer_unik from customer
	group by domisili order by banyak_customer_unik desc;

#menentukan produk yang paling banyak diminati dari setiap domisili
select customer.domisili, tipe_produk, 
	count(transaction.tipe_produk) as Banyaknya_pembelian
    from transaction 
    join customer on transaction.nama_customer = customer.nama_customer
	where customer.domisili = 'jawa barat'
    group by tipe_produk
    order by Banyaknya_pembelian desc ;
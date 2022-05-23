#Tran Hoang Bao Ly
#21521109
#20
.data
	 Array: .space 400
	 nhapn: .asciiz "Nhap n la so phan tu cua mang nguyen duong (n>0 va n<=100): "
	 nhaploi: .asciiz "So n ban vua nhap khong phu hop (n<=0 hoac n>100), moi nhap lai: "
	 nhapso: .asciiz "Nhap phan tu thu "
	 haicham: .asciiz ": "
	 space: .asciiz " "
	 nhapsoam: .asciiz "So ban vua nhap <=0, moi ban nhap lai: "
	 inmang: .asciiz " A[] =  "
	 xuonghang: .asciiz "\n"
	 Tong: .asciiz "Tong la: "
	 Max: .asciiz "So lon nhat la: "
	 Min: .asciiz "So be nhat la: "
	 Sochan: .asciiz "So phan tu chan la: "
	 Sole: .asciiz "So phan tu le la: "
	 
.text 
main:
	li $v0, 4 # write string
	la $a0, nhapn	
	syscall
	
	li $v0, 5 #read integer
	syscall
	addi $t0, $v0, 0 #t0 = v0 (n = input())
		
	#Neu so vua nhap khong thoa dieu kien nhap lai

	WHILE: 
		slti $t1, $t0, 1  #t1 = t0<1? 1 : 0
		addi $t2, $0, 100 #t2 = 100
		slt $t2, $t2, $t0 #t2 = 100<t0? 1: 0
		or $t1,$t1,$t2 #t1 = t1|t2
		
		beq $t1,$0, ENDWhile
		
		li $v0, 4 # write string
		la $a0, nhaploi	
		syscall
		li $v0, 5 #read integer
		syscall
		addi $t0, $v0, 0 #t0 = v0
		
		j WHILE
	ENDWhile:
	
	#Khoi tao mang va i = 0
	la $s0, Array 
	addi $t1, $zero, 0
	#Nhap gia tri cho tung phan tu 
	FOR: 
		slt $t2,$t1, $t0 # t2 = t1<t0?1:0
		beq $t2,$0 ENDFOR #if (t2 == 0) break
		li $v0, 4 # write string
		la $a0, nhapso
		syscall
		li $v0, 1 #write int
		addi $a0, $t1, 1
		syscall
		
		li $v0, 4 # write string
		la $a0, haicham
		syscall
		
		li $v0, 5 #read int
		syscall
		addi $s1, $v0,0 #s0 = input() (from v0)
		
		#Neu so am, nhap lai so vua nhap
		AW:
			slti $t2, $s1, 1 # t2 = s1<0?1:0
			beq $t2, $0 ENDAW #if (t2 == 0) break;
			li $v0, 4 # write string
			la $a0, nhapsoam
			syscall
			li $v0, 5 #read int
			syscall
			addi $s1, $v0,0 #s0 = input() (from v0)
			J AW
		ENDAW:
		#Luu so vua nhap vao mang
		sll $s2, $t1,2 #s2 = t1*4
		add $s2, $s2, $s0
		sw $s1, ($s2)	#Arr[i] = s1;
		
		addi $t1,$t1,1
		j FOR
	ENDFOR:
	#Tinh cac yeu cau cua bai toan
	addi $t1, $zero, 0
	addi $s1, $zero, 0 # s1  = tong mang
	lw $t2, 0($s0) #t2 = A[i]
	addi $s2, $zero, 0 # s2 = max
	addu $s3, $t2, $zero  #s3 = min
	addi $s4, $zero, 0  #s4 = so so le
	addi $s5, $zero, 0  #s5 = so so chan
	FOR2:
		slt $t2,$t1, $t0 # t2 = t1<t0?1:0
		beq $t2,$0 ENDFOR2 #if (t2 == 0) break
		lw $t2, 0($s0) #t2 = A[i]
		add $s1, $s1, $t2 #s1 = s1 + t2 tinh tong
		slt $t3, $s2, $t2 #t3 = s2<t2?1:0
		beq $t3, $0 ToMin
			addi $s2, $t2, 0
		ToMin:
		slt $t3, $t2, $s3 #t3 = t2<s3?1:0
		beq $t3, $0 ToChan
			addi $s3, $t2, 0
		ToChan:
		andi $t2, $t2, 1   #t2 = t2%2 == 0? 0:1
		bne $t2, $0 TinhLe
			addi $s4,$s4,1
			j EndChanLe
		TinhLe:
			addi $s5,$s5,1
		EndChanLe:
		addi $s0, $s0, 4 # Arr+=4
		addi $t1, $t1,1 # i++
		j FOR2
	ENDFOR2:
	#In Cac yeu cau:
	#Tong
	li $v0, 4
	la $a0, Tong
	syscall # in dong chu thich
	li $v0, 1
	addi $a0, $s1, 0
	syscall #in tong 
	li $v0, 4
	la $a0, xuonghang
	syscall #xuong dong
	
	#In max
	li $v0, 4
	la $a0, Max
	syscall # in dong chu thich
	li $v0, 1
	addi $a0, $s2, 0
	syscall #in max
	li $v0, 4
	la $a0, xuonghang
	syscall #xuong dong
	
	#in min
	li $v0, 4
	la $a0, Min
	syscall # in dong chu thich
	li $v0, 1
	addi $a0, $s3, 0
	syscall #in min 
	li $v0, 4
	la $a0, xuonghang
	syscall #xuong dong
	
	#in so so chan
	li $v0, 4
	la $a0, Sochan
	syscall # in dong chu thich
	li $v0, 1
	addi $a0, $s4, 0
	syscall #in so so chan 
	li $v0, 4
	la $a0, xuonghang
	syscall #xuong dong
	
	#in so so le
	li $v0, 4
	la $a0, Sole
	syscall # in dong chu thich
	li $v0, 1
	addi $a0, $s5, 0
	syscall #in so so le 
	li $v0, 4
	la $a0, xuonghang
	syscall #xuong dong
		
		
		
		
		
	
		
	
	

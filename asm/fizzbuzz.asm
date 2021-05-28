section .data
str_fizz: db "fizz"
str_buzz: db "buzz"
str_numbers: db "0123456789"
str_newline: db 10

section .text
global _start

; fizz の表示
print_fizz:
    mov rax, 1
    mov rdi, 1
    mov rsi, str_fizz
    mov rdx, 4

    push rcx
    syscall
    pop rcx

    ret

; buzz の表示
print_buzz:
    mov rax, 1
    mov rdi, 1
    mov rsi, str_buzz
    mov rdx, 4

    push rcx
    syscall
    pop rcx

    ret

; カウンターの数字を3桁の10進数として表示する
print_number:
    ; カウンターを 100 で割って商を表示
    mov rdx, 0
    mov rax, rcx
    mov rbx, 100
    div rbx
    ; 余りを次で使うので保存
    push rdx
    call print_rax_number

    ; 余りを 10 で割って商を表示
    pop rax
    mov rdx, 0
    mov rbx, 10
    div rbx
    ; 余りを次で使うので保存
    push rdx
    call print_rax_number

    ; 余りを 1 の位として表示
    pop rax
    call print_rax_number

    ret

; rax に入っている数字を文字列として表示
print_rax_number:
    lea rsi, [str_numbers + rax]
    mov rax, 1
    mov rdi, 1
    mov rdx, 1

    push rcx
    syscall
    pop rcx

    ret

; 改行の表示
print_newline:
    mov rax, 1
    mov rdi, 1
    mov rsi, str_newline
    mov rdx, 1

    push rcx
    syscall
    pop rcx

    ret

; fizz を表示するかチェック
; カウンターを 3 で割って 0 と比較だけしておく
; 0 なら je LABEL でラベルにジャンプできる
check_fizz:
    mov rdx, 0
    mov rax, rcx
    mov rbx, 3
    div rbx
    cmp rdx, 0
    ret

; fizz と同じように buzz のチェック
check_buzz:
    mov rdx, 0
    mov rax, rcx
    mov rbx, 5
    div rbx
    cmp rdx, 0
    ret

; 終了
exit:
    mov rax, 60
    xor rdi, rdi
    syscall

_start:
    ; カウンターの初期化
    mov rcx, 1

    .loop:
        ; fizz のチェックとジャンプ
        call check_fizz
        je .print_fizz

        ; fizz じゃなければ buzz のチェックとジャンプ
        call check_buzz
        je .print_buzz

        ; fizz でも buzz でもなければカウンターを10進数で表示
        .print_default:
            call print_number
            call print_newline
            jmp .next

        ; fizz の表示
        .print_fizz:
            call print_fizz

            ; fizzbuzz のケースのためにチェックとジャンプ
            call check_buzz
            je .print_buzz

            call print_newline
            jmp .next

        ; buzz の表示
        .print_buzz:
            call print_buzz
            call print_newline
            jmp .next

        .next:

        ; カウンターをインクリメントし 100 以下ならループする
        inc rcx
        cmp rcx, 100
        jle .loop

    call exit

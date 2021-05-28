section .data
numbers: db "0123456789", 10
strings: db "ABCDEFGHIJ", 10

section .text
global _start

; 関数定義は単なるラベルで、終端で ret するだけ
print_numbers:
    mov rax, 1
    mov rdi, 1
    ; 出力する文字をカウンター分だけずらして一文字ずつ表示する
    ; mov を使って相対アドレスを指定する場合は一度 mov でベースをセットしてから add でオフセット分ずらす
    mov rsi, numbers
    add rsi, rcx
    mov rdx, 1
    push rcx
    syscall
    pop rcx
    ret

print_strings:
    mov rax, 1
    mov rdi, 1
    ; lea A, B とすると A のアドレスを計算して B に入れる.
    ; lea を使うとひとつのコマンドで相対アドレスを指定することができる
    lea rsi, [strings + rcx]
    mov rdx, 1
    push rcx
    syscall
    pop rcx
    ret

; ついでに exit も関数化
exit:
    mov rax, 60
    xor rdi, rdi
    syscall

_start:
    mov rcx, 0

.loop:
    ; 関数呼び出しは call
    call print_numbers
    call print_strings

    ; 数値比較によるジャンプ
    ; jle は jump if less or equals
    inc rcx
    cmp rcx, 10
    jle .loop

    call exit

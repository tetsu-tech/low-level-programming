section .data

message: db "Hello, World", 10

section .text

global _start

_start:

    ; レジスタ rcx をカウンターとして利用する. 初期値 3
    mov rcx, 3

.loop:
    ; カウンターをデクリメント
    dec rcx

    ; write システムコールのパラメータセット
    mov rax, 1
    mov rdi, 1
    mov rsi, message
    mov rdx, 13

    ; push コマンドでカウンターをスタックに一時保存
    ; rcx は syscall の返り値が挿入されるので上書きされても復帰できるように対比しておく
    push rcx
    ; write の実行
    syscall
    ; pop コマンドでカウンターをスタックから復帰させる
    pop rcx

    ; test コマンドでカウンターが 0 であるかどうかをチェックする.
    ; もし 0 なら zero flag が立つ
    test rcx, rcx
    ; jnz は jump if not zero の意味. zero flag が立っていなければ対象の .loop ラベルのアドレスへジャンプする.
    jnz .loop

    ; exit の実行
    mov rax, 60
    xor rdi, rdi
    syscall

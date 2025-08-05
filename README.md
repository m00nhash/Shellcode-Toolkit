# Shellcode-Toolkit
This project contains handcrafted Windows x64 shellcode that runs without using any imports. It includes two main payloads:

1] simple MessageBox shellcode that displays a message using direct API resolution.

2] A fully working reverse shell, written in position-independent assembly, that connects back to a listener and gives remote command execution.

Both shellcodes are designed to be clean, minimal, and stealthy — using techniques like PEB walking and avoiding static imports. They can be used for learning purposes, red teaming, or understanding how low-level Windows shellcode works under the hood.

# 🔥 Win64 Shellcode Toolkit

- Resolves API addresses via PEB
- Avoids static imports (fully PIC)
- Supports: MessageBoxA and Reverse Shell

## ✨ Features

- [x] MessageBoxA shellcode (no imports)
- [x] Reverse shell (custom socket setup)
- [x] Manual API resolution

## 💡 Why?

To demonstrate deep understanding of Windows internals and shellcode crafting techniques.

## 🧠 Concepts Covered

- PEB walking
- Shellcode safety (stack alignment, PIC)

## 🔧 Build

```bash
nasm -f win64 shellcode.asm -o shellcode.obj
link /SUBSYSTEM:CONSOLE /ENTRY:main shellcode.obj


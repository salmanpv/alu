# ALU Module for Single-Cycle RISC-V Processor

This ALU module is designed to work within the single-cycle RISC-V processor as shown in textbook datapath diagrams. It includes both the core ALU functionality and the operand-selection mux inside the module.

---

## 🔧 ALU Features

* Supports arithmetic and logical operations:

  * `ADD`  (Opcode: `000`)
  * `SUB`  (Opcode: `001`)
  * `AND`  (Opcode: `010`)
  * `OR`   (Opcode: `011`)
  * `XOR`  (Opcode: `100`)
* Computes a `Zero` flag for use in branching (e.g., `beq`)
* Internal mux to choose between:

  * Register operand (RegData2)
  * Immediate operand (ImmExt)
  * Based on control signal `ALUSrc`

---

## 📥 Inputs

| Signal       | Width  | Description                             |
| ------------ | ------ | --------------------------------------- |
| `SrcA`       | 32-bit | First operand (from register)           |
| `RegData2`   | 32-bit | Second operand from register (RD2)      |
| `ImmExt`     | 32-bit | Extended immediate value                |
| `ALUSrc`     | 1-bit  | Selects between `RegData2` and `ImmExt` |
| `ALUControl` | 3-bit  | Operation selector from ALU decoder     |

---

## 📤 Outputs

| Signal      | Width  | Description                                  |
| ----------- | ------ | -------------------------------------------- |
| `ALUResult` | 32-bit | Result of selected ALU operation             |
| `Zero`      | 1-bit  | Set to 1 if result is zero (used for branch) |

---

## ✅ Example Use Cases

| Instruction      | ALU Operation | ALUSrc | ALUControl |
| ---------------- | ------------- | ------ | ---------- |
| `add x1, x2, x3` | `x2 + x3`     | 0      | 000        |
| `addi x1, x2, 5` | `x2 + 5`      | 1      | 000        |
| `beq x1, x2, X`  | `x1 - x2`     | 0      | 001        |
| `and x1, x2, x3` | `x2 & x3`     | 0      | 010        |
| `xor x1, x2, x3` | `x2 ^ x3`     | 0      | 100        |

---

## 🧩 Integration Notes

* `ALUSrc` is controlled by the main control unit.
* `ALUControl` comes from the ALU Decoder, which interprets `funct3`, `funct7`, and `ALUOp`.
* This ALU module replaces the external SrcB mux from the top-level datapath.

---

## 📁 File: `alu.v`

Contains the Verilog module for this updated ALU.

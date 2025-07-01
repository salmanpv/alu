## 🧠 Data Memory – RV32I Single-Cycle Processor

The Data Memory module is responsible for storing and retrieving 32-bit data values for load (`lw`) and store (`sw`) instructions in the RV32I architecture. It is accessed during the memory stage of instruction execution.

### ✅ Function
- Reads from memory for `lw` (load word)
- Writes to memory for `sw` (store word)
- Access is word-aligned (address must be divisible by 4)

---

### 🔌 Port Summary

| Port Name     | Width     | Direction | Description                            |
|---------------|-----------|-----------|----------------------------------------|
| `clk`         | 1 bit     | Input     | Clock signal                           |
| `MemRead`     | 1 bit     | Input     | Enables read operation                 |
| `MemWrite`    | 1 bit     | Input     | Enables write operation                |
| `addr`        | 32 bits   | Input     | Word-aligned memory address            |
| `write_data`  | 32 bits   | Input     | Data to write (for store)              |
| `read_data`   | 32 bits   | Output    | Data read from memory (for load)       |

---

### 📌 Notes
- Memory is assumed to be synchronous for writes (triggered on rising edge of clk)
- Reads are combinational (data is available during same cycle if MemRead is high)
- No memory operation occurs unless either MemRead or MemWrite is high

---

### 🛠️ Usage Example (within top-level CPU)
- For `lw x5, 0(x1)`:
  - `addr` = contents of x1
  - `MemRead = 1`
  - `read_data` is routed to write-back stage → x5
- For `sw x2, 0(x3)`:
  - `addr` = contents of x3
  - `write_data` = contents of x2
  - `MemWrite = 1`


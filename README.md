# Console Driver IHS Project - Game Implementation on DE2i-150 Board

This project was developed as part of the **IF817 - Interface Hardware-Software** course at UFPE, consisting of implementing an interactive game running on a **DE2i-150** (Intel/Altera) development board, including the complete development of device drivers necessary for communication with the board's peripherals.

## Team Members

1. **Artur Vinicius Pereira Fernandes** - (arturvpf)
2. **Felipe Mateus Falcão Barreto** - (felipemfb)
3. **João Victor da Silva Nascimento** - (jvsn2)
4. **Felipe Torres** - (felipetmacedo)
5. **Matheus Ayres dos Santos** - (mas11)
6. **Breno Ramos** - (brsg)


## About the Project

The project implements a complete system that includes:

### **Interactive Game**
- Game developed to run directly on the DE2i-150 board
- Uses available peripherals on the board for user interaction
- Interface through buttons, switches, LEDs, and 7-segment displays

### **Device Drivers**
- **PCI Driver**: Communication with DE2i-150 board via PCI bus
- **Char Driver**: Character device driver for basic operations
- Complete implementation of read/write operations and ioctl

### **Supported Peripherals**
The DE2i-150 board has several peripherals controlled through the drivers:

- **Switches**: Slide switches for data input
- **Push Buttons**: Buttons for commands and control
- **Red/Green LEDs**: Visual indicators and feedback
- **7-Segment Displays**: Numeric display (left and right)
- **PCI Interface**: High-speed communication with the system

## System Architecture

```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   Application   │◄──►│     Drivers      │◄──►│   DE2i-150      │
│     (Game)      │    │  (PCI + Char)    │    │     Board       │
└─────────────────┘    └──────────────────┘    └─────────────────┘
         │                       │                       │
         │              ┌────────▼────────┐             │
         └──────────────►│  Linux Kernel   │◄────────────┘
                         └─────────────────┘
```

## Detailed Project Structure

### **`driver/`** - Kernel Modules
- **`pci/de2i-150.c`**: Main PCI driver for board communication
  - Implements memory-mapped I/O (MMIO) operations
  - Controls all peripherals via ioctl commands
  - Supports read/write operations for devices
- **`char/dummy.c`**: Example character device driver
  - Basic file operations implementation
  - Used for testing and development

### **`include/`** - System Headers
- **`ioctl_cmds.h`**: ioctl command definitions for peripheral control
- **`display.h`**: Constants for 7-segment display control

### **`src/`** - Main Code
- **`main.cpp`**: Main game application (under development)

### **`exemples/`** - Examples and Tests
- **`c/`**: C examples for driver testing
  - `app-pci.c`: Demonstrates PCI driver usage
  - `app-char.c`: Demonstrates character driver usage
- **`python/`**: Python versions of examples

### **`jogo_main/`** - Game Implementation
- Directory for main game implementation

## Available ioctl Commands

The driver supports the following commands for peripheral control:

```c
#define RD_SWITCHES   _IO('a', 'a')  // Read switches
#define RD_PBUTTONS   _IO('a', 'b')  // Read push buttons  
#define WR_L_DISPLAY  _IO('a', 'c')  // Write to left display
#define WR_R_DISPLAY  _IO('a', 'd')  // Write to right display
#define WR_RED_LEDS   _IO('a', 'e')  // Control red LEDs
#define WR_GREEN_LEDS _IO('a', 'f')  // Control green LEDs
```

## How to Compile and Run

### Prerequisites
- Linux system with kernel headers
- DE2i-150 board connected via PCI
- Superuser permissions

### Compilation
```bash
# Compile main application
make

# Compile PCI driver
cd driver/pci
make

# Or use the complete setup script
./setup.sh
```

### Driver Installation
```bash
# Load module into kernel
sudo insmod driver/pci/de2i-150.ko

# Configure device permissions
sudo chmod 666 /dev/mydev
```

## Additional Resources

- **[Useful Commands](docs/commands.md)**: Complete list of development commands
- **Makefile**: Simplified build system
- **setup.sh**: Automated environment setup script

## Academic Context

This project demonstrates fundamental concepts of:
- **Systems Programming**: Kernel-level development
- **Device Drivers**: Linux module implementation
- **Hardware/Software Interface**: Direct peripheral interfacing
- **PCI Communication**: High-speed bus protocols
- **Embedded Programming**: Platform-specific development

---

**NOTE**: This project structure is provided as a development base. The build system is simplified but can be adapted as needed. The `driver/` directory contains essential Makefiles that should not be removed.

## Content
 - [Useful Commands](docs/commands.md)

## Current project tree

	.
	├── src
	│   └── main.cpp
	├── include
	│   ├── display.h
	│   └── ioctl_cmds.h
	├── driver
	│   ├── char
	│   │   ├── dummy.c
	│   │   └── Makefile
	│   └── pci
	│       ├── de2i-150.c
	│       └── Makefile
	├── exemples
	│   ├── c
	│   │   ├── app-char.c
	│   │   └── app-pci.c
	│   └── python
	│       ├── app-char.py
	│       └── app-pci.py
	├── docs
	│   └── commands.md
	├── LICENSE
	├── Makefile
	├── README.md
	└── setup.sh

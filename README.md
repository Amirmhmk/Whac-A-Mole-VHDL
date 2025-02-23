# **Whac-A-Mole VHDL Simulation**  

## **Overview**  
This project is a hardware implementation of the *Whac-A-Mole* game using VHDL. The design simulates the game logic, including mole appearance, player interaction, scoring, and game timing. The project was developed as part of a university course on *Computer-Aided Design* at the **University of Guilan, Computer Engineering Department**.
![image](https://github.com/user-attachments/assets/afb8530d-ddbf-43d1-b743-a9988ff224e1)


## **Features**  
- **Game Mechanics**:  
  - The game starts with five random holes.  
  - Moles appear in random holes and must be hit within a limited time.  
  - The player must react quickly to score points.  
  - Bombs and coins add complexity to the game.  
- **Scoring System**:  
  - Points are awarded for hitting moles.  
  - Incorrect hits and bombs affect the score.  
- **Randomization**:  
  - Uses a Linear Feedback Shift Register (LFSR) for pseudo-random number generation.  
- **VHDL Implementation**:  
  - Designed using *Active-HDL*.  
  - Includes a testbench for verification.  

## **Project Structure**  
```
/Whac-A-Mole-VHDL
│── Hole_and_hammer.vhd  # Main VHDL implementation
│── testbench.vhd        # Testbench for simulation
│── CAD-Project.pdf      # Project documentation
└── README.md 
```

## **How to Run**  
1. Open the project in **Active-HDL** or any VHDL simulator.  
2. Load the `Hole_and_hammer.vhd` file.  
3. Run the testbench to validate the design.  
4. Observe the simulation waveforms to verify game logic.  

## **Simulation Outputs**  
- `score`: Tracks the player's score.  
- `time_left`: Indicates the remaining game time.  
- `bomb`: Triggers a penalty if hit.  
- `coin`: Grants bonus points.  
- `finish`: Signals the end of the game.  

## **Future Improvements**  
- Add FPGA synthesis compatibility.  
- Implement a graphical display for visualization.  
- Enhance randomization logic for better gameplay experience.  

## **Contributors**  
- **Amir Mohammadkhah** – Student
- **University of Guilan** – Computer Engineering Department  


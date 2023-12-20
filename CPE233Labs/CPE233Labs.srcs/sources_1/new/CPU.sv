`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Nathan Jaggers
// 
// Create Date: 02/08/2021 01:05:52 PM
// Description:  
//////////////////////////////////////////////////////////////////////////////////


module CPU(
    input  CPU_RST,
    input  CPU_INTR,
    input  [31:0] CPU_IOBUS_IN,
    input  CPU_CLK,
    output CPU_IOBUS_WR,
    output [31:0] CPU_IOBUS_OUT,
    output [31:0] CPU_IOBUS_ADDR
    
    );
    
    //define extra signals
      logic PCWrite, reset, memRDEN1, memRDEN2, memWE2, regWrite, alu_srcA, br_eq, br_lt, br_ltu, mie, csr_WE, 
            int_taken;
      logic [1:0] rf_wr_sel, alu_srcB;
      logic [2:0] pcSource;
      logic [3:0] alu_func ;
      logic [31:0] pcDin, count, jalr, branch, jal, mtvec, mepc, rs1, rs2, ir, dout2, wd, RD,
                   srcA, srcB, Utype, Itype, Stype, Btype, Jtype;
        
    //link modules
    ProgramCounter              PC(.PC_CLK(CPU_CLK), .PC_WRITE(PCWrite), .PC_RESET(reset), .PC_DIN(pcDin), .PC_COUNT(count));
    
    mux                         MUXPC(.MUX_INPUT_PC(count+4),.MUX_JALR(jalr),.MUX_BRANCH(branch),.MUX_JAL(jal),
                                      .MUX_MTEVC(mtvec),.MUX_MEPC(mepc),.MUX_pcSource(pcSource), .MUX_out(pcDin));
                                      
    Memory                      MEM(.MEM_CLK(CPU_CLK),.MEM_RDEN1(memRDEN1),.MEM_RDEN2(memRDEN2),.MEM_WE2(memWE2),
                                    .MEM_ADDR1(count[15:2]),.MEM_ADDR2(CPU_IOBUS_ADDR),.MEM_DIN2(rs2),.MEM_SIZE(ir[13:12]),
                                    .MEM_SIGN(ir[14]),.IO_IN(CPU_IOBUS_IN),.IO_WR(CPU_IOBUS_WR),.MEM_DOUT1(ir),.MEM_DOUT2(dout2));
                                    
    RegisterFile                RegFile(.RF_ADR1(ir[19:15]),.RF_ADR2(ir[24:20]),.RF_WA(ir[11:7]),.RF_WD(wd),.RF_EN(regWrite),
                                        .RF_CLK(CPU_CLK),.RF_RS1(rs1),.RF_RS2(rs2));
                                        
    ArithmeticLogicUnit         ALU(.ALU_A(srcA),.ALU_B(srcB),.ALU_func(alu_func),.ALU_result(CPU_IOBUS_ADDR));
    
    ImmediateGenerator          ImmedGen(.IG_instruction(ir),.IG_Utype(Utype),.IG_Itype(Itype),.IG_Stype(Stype),
                                         .IG_Jtype(Jtype),.IG_Btype(Btype));
                                         
    BranchAddressGenerator      BAG(.BAG_PC(count),.BAG_Jtype(Jtype),.BAG_Btype(Btype),.BAG_Itype(Itype),.BAG_register(rs1),
                                    .BAG_jal(jal),.BAG_branch(branch),.BAG_jalr(jalr));
                                    
    BranchConditionGenerator    BCG(.BCG_A(rs1),.BCG_B(rs2),.BCG_equal(br_eq),.BCG_lessThan(br_lt),.BCG_lessThanUnsigned(br_ltu));
    
    ControlUnitFSM              CUFSM(.CUFSM_rst(CPU_RST),.CUFSM_Interupt(CPU_INTR && mie),.CUFSM_opCode(ir[6:0]),
                                      .CUFSM_func(ir[14:12]),.CUFSM_clk(CPU_CLK),.CUFSM_pcWr(PCWrite),.CUFSM_regWr(regWrite),
                                      .CUFSM_memWrEn2(memWE2),.CUFSM_memRdEn1(memRDEN1),.CUFSM_memRdEn2(memRDEN2),
                                      .CUFSM_Reset(reset),.CUFSM_csrWE(csr_WE),.CUFSM_intrTaken(int_taken));
                                      
    ControlUnitDecoder          CUDCDR(.CUDCDR_opCode(ir[6:0]),.CUDCDR_func(ir[14:12]),.CUDCDR_funcBit(ir[30]),
                                       .CUDCDR_intrTaken(int_taken),.CUDCDR_brEq(br_eq),.CUDCDR_brLt(br_lt),
                                       .CUDCDR_brLtu(br_ltu),.CUDCDR_aluFunc(alu_func),.CUDCDR_aluSRCA(alu_srcA),
                                       .CUDCDR_aluSRCB(alu_srcB),.CUDCDR_pcSRC(pcSource),.CUDCDR_rfwSel(rf_wr_sel));
                                     
    ControlStatusRegisters      CSR(.CSR_RST(reset), .CSR_INT_TAKEN(int_taken), .CSR_ADDR(ir[31:20]), .CSR_WR_EN(csr_WE), 
                                    .CSR_PC(count), .CSR_WD(rs1), .CSR_CLK(CPU_CLK), .CSR_MIE(mie), .CSR_MEPC(mepc), 
                                    .CSR_MTVEC(mtvec), .CSR_RD(RD));

    assign CPU_IOBUS_OUT = rs2; 
    //other muxes for circuit
    //regfile mux
    always_comb
    begin
        case(rf_wr_sel)
            2'b00:  wd = count + 4;
            2'b01:  wd = RD;
            2'b10:  wd = dout2;
            2'b11:  wd = CPU_IOBUS_ADDR;
            default: wd = 32'h00000000   ; 
        endcase
    end
    
    //ALU srcA and srcB muxes
    always_comb
    begin
        case(alu_srcA)
            1'b0:  srcA = rs1;
            1'b1:  srcA = Utype;
            default: srcA = 32'h00000000  ; 
        endcase
    end
    
    always_comb
    begin
        case(alu_srcB)
            2'b00:  srcB = rs2;
            2'b01:  srcB = Itype;
            2'b10:  srcB = Stype;
            2'b11:  srcB = count;
            default: srcB = 32'h00000000   ; 
        endcase
    end
    
endmodule

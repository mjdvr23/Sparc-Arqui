//ALU MODULE 
//Author: Mikael J. Del Valle ROdriguez


module alu (a, b, carry, alu_operation, alu_output, N_flag, Z_flag, C_flag, V_flag);

	input signed [31:0] a, b;
    input carry;
    input [5:0] alu_operation;

    output reg [31:0] alu_output;
    output reg N_flag;
    output reg Z_flag;
    output reg C_flag;
    output reg V_flag;

    always@(a,b,alu_operation)
    begin
    case(alu_operation)

    //Arithmetic Instuction
        6'b000000: alu_output = a + b;              //add  rd<= rs1 + rs2|simm13

        6'b010000: begin                            //addcc rd<= rs1 + rs2|simm13, modify icc
            {C_flag, alu_output} = a + b;
            N_flag=alu_output[31];
            if(alu_output == 0)
                Z_flag = 1;
            else
                Z_flag = 0;
            if(a[31] == b[31] && alu_output[31] != a[31])
                V_flag = 1;
            else
                V_flag = 0;
         end      

        6'b001000: alu_output = a + b + carry;     //addx rd<= rs1 + rs2|simm13 + carry

        6'b011000: begin                           //addxcc rd<= rs1 + rs2|simm13 + carry, modify 
            {C_flag, alu_output} = a + b + carry; 
            N_flag=alu_output[31];
            if(alu_output == 0)
                Z_flag = 1;
            else
                Z_flag = 0;
            if(a[31] == b[31] && alu_output[31] != a[31])
                V_flag = 1;
            else
                V_flag = 0;     
        end


        6'b000100: alu_output = a - b;              //sub   rd<= rs1 - rs2|simm13

        6'b010100: begin                           //subcc rd<= rs1 - rs2|simm13, modify icc
            {C_flag, alu_output} = a - b;
            N_flag = alu_output[31];
            if(alu_output==0)
                Z_flag = 1;
            else
                Z_flag = 0;
            if(a[31] != b[31] && alu_output[31] != a[31])
                V_flag = 1;
            else
                V_flag = 0;
        end

        6'b001100: alu_output = a - b - carry;      //subx rd<= rs1 - rs2|simm13 - carry

        6'b011100: begin                            //subxcc rd<= rs1 - rs2|simm13 - carry, modify icc
            {C_flag, alu_output} = a - b - carry;
            N_flag = alu_output[31];
            if( alu_output == 0)
                Z_flag = 1;
            else
                Z_flag = 0;
            if(a[31] != b[31] && alu_output[31] != a[31])
                V_flag = 1;
            else
                V_flag = 0;
        end

//Logical Instructions
        6'b000001: alu_output = a & b;              //and rd<= rs1 bitwise AND rs2|simm13

        6'b010001: begin                            //andcc rd<= rs1 bitwise AND rs2|simm13, modify icc
            {C_flag, alu_output} = a & b;
            N_flag = alu_output[31];
            if( alu_output == 0)
                Z_flag = 1;
            else
                Z_flag = 0;
            V_flag = 0;
            end

        6'b000101: alu_output = a & (~b);        //andn rd<= rs1 bitwise AND NOT(rs2|simm13)

        6'b010101: begin                            //andncc rd<= rs1 bitwise AND NOT(rs2|simm13), modify icc
            {C_flag, alu_output} = a & (~b);
            N_flag = alu_output[31];
            if( alu_output==0)
                Z_flag = 1;
            else
                Z_flag = 0;
            V_flag = 0;        
        end

        6'b000010: alu_output = a | b;              //or rd<= rs1 bitwise OR rs2|simm13

        6'b010010: begin                            //orcc rd<= rs1 bitwise OR rs2|simm13, modify icc
            {C_flag, alu_output} = a | b;
            N_flag = alu_output[31];
            if( alu_output==0)
                Z_flag=1;
            else
                Z_flag=0;
            V_flag=0;
        end

        6'b000110: alu_output = a | (~b);          //orn rd<= rs1 bitwise OR NOT(rs2|simm13)

        6'b010110: begin                           //orncc rd<= rs1 bitwise OR NOT(rs2|simm13), modify icc
            {C_flag, alu_output} = a | (~b);
            N_flag = alu_output[31];
            if( alu_output==0)
                Z_flag=1;
            else
                Z_flag=0;
            V_flag=0;
        end

        6'b000011: alu_output = a ^ b;          //xor rd<= rs1 bitwise XOR rs2|simm13

        6'b010011: begin                           //xorcc  rd<= rs1 bitwise XOR rs2|simm13, modify icc
            {C_flag, alu_output} = a ^ b;
            N_flag = alu_output[31];
            if (alu_output==0)
                Z_flag=1;
            else
                Z_flag=0;
            V_flag=0;
        end

        6'b000111: alu_output = a ^ (~b);         //xorn rd<= rs1 bitwise XOR NOT(rs2|simm13)

        6'b010111: begin                          //xorncc rd<= rs1 bitwise XOR NOT(rs2|simm13), modify icc
            {C_flag, alu_output} =  a ^ (~b);
            N_flag = alu_output[31];
            if (alu_output==0)
                Z_flag=1;
            else
                Z_flag=0;
            V_flag=0;
        end

//Shift Instructions
        6'b100101: alu_output = a<<b[4:0];   //sll 
        6'b100110: alu_output = a>>b[4:0];   //srl
        6'b100111: alu_output = a>>>b[4:0];  //sra

endcase
end
endmodule
    

    
    
    
    

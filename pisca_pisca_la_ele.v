
module lasid (
    input clk, rst,
    input f0, f1,
    output reg led0, led1, led2
);
    reg [32:0] count;
    reg [32:0] cooldowm;
    reg um, dois, tres;

    reg [3:0] estado;
    parameter inicio = 0, verifica = 1, acendeum = 2, acendedois = 3, acendetres = 4, delayum = 5, delaydois = 6, delaytres = 7;

    always @(*) begin

        case (estado)
            inicio : begin
                led0 = 0;
                led1 = 0;
                led2 = 0;
            end

            verifica : begin
                led0 = um;
                led1 = dois;
                led2 = tres;
            end

            acendeum : begin
                led0 = um;
                led1 = dois;
                led2 = tres;
            end

            acendedois : begin
                led0 = um;
                led1 = dois;
                led2 = tres;
            end

            acendetres : begin
                led0 = um;
                led1 = dois;
                led2 = tres;
            end

            delayum : begin
                led0 = um;
                led1 = dois;
                led2 = tres;
            end

            delaydois : begin
                led0 = um;
                led1 = dois;
                led2 = tres;
            end

            delaytres : begin
                led0 = um;
                led1 = dois;
                led2 = tres;
            end
                
            
        endcase
    end
endmodule


always @(clk, rst) begin
    
    if (~rst) 
        estado <= inicio; count = 0;
    else 
        case (estado)

            inicio : 
                estado <= verifica;
            
            verifica :
                if (!f0 && !f1) begin
                    cooldowm <= 100000000;
                end

                if (!f0 && f1) begin
                    cooldowm <= 50000000;
                end

                if (f0 && !f1) begin
                    cooldowm <= 25000000
                end
                
                if (f0 && f1) begin
                    cooldowm <= 12500000;
                end

                estado <= acendeum;
            
            acendeum :
                um <= 1;
                dois <= 0;
                tres <= 0;

                count <= 0;
                estado <= delayum;

            acendedois :
                um <= 0;
                dois <= 1;
                tres <= 0;

                count <= 0;
                estado <= delaydois;
            
            acendetres :
                um <= 0;
                dois <= 0;
                tres <= 1;
                
                count <= 0;
                estado <= delaytres;

            delayum :
                count <= count + 1;
                if (count >= cooldowm) begin
                    estado <= acendedois;
                end

            delaydois :
                count <= count + 1;
                if (count >= cooldowm) begin
                    estado <= acendetres;
                end
            
            delaytres :
                count <= count + 1;
                if (count >= cooldowm) begin
                    estado <= inicio;
                end
                

        endcase
end

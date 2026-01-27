class c_1_1;
    rand bit[0:0] AWADDR; // rand_mode = ON 

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (tb/axi_seq.sv:14)
    {
       (AWADDR == 32'ha);
    }
endclass

program p_1_1;
    c_1_1 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "10xz001xxx1xzxxxx010z01z11z0z0xzxzzzzzzzxzzzzzzxzzxxxzxxzzxxxxzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram

class fifo_base_test extends uvm_test;
  `uvm_component_utils(fifo_base_test)

  virtual fifo_interface vif;
  fifo_env env;

  function new(string name = "fifo_base_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual fifo_interface)::get(this, "", "vif", vif)) begin
      `uvm_error("build_phase", "Failed to get virtual interface from config DB")
    end
    env = fifo_env::type_id::create("env", this);
  endfunction

  function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    `uvm_info("DEBUG", "Printing UVM topology...", UVM_LOW)
    uvm_root::get().print_topology();
  endfunction

endclass

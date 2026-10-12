`ifndef CONNFIG_DB_SV
`define CONNFIG_DB_SV

// antes era de puros enteros ahora es de int de real de clases 

class config_db #(
    type T
);

  static T db[string];

  static function void set(string key, T value);

    db[key] = value;

  endfunction

  static function void get(string key, ref T value);

    value = db[key];

  endfunction

  static function void print();

    $display("Configuration Database %s", $typename(T));

    foreach (db[key]) $display("%s %p", key, db[key]);

  endfunction

endclass

`endif


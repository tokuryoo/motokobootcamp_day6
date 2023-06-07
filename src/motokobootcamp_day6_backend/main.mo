import Float "mo:base/Float";
import Int "mo:base/Int";
import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";
import Nat "mo:base/Nat";

// TODO null や 0 の取り扱いについて、何かバグがあるかもしれない。
actor class Calculator() {
  let calculatedValues = HashMap.HashMap<Principal, Float>(1, Principal.equal, Principal.hash);
  var counter : Float = 0.0;

  public shared ({ caller }) func add(x : Float) : async Float {
    // TODO Principal.isAnonymous
    var oldValue = calculatedValues.get(caller);
    switch (oldValue) {
      case null {
        let newValue = x;
        calculatedValues.put(caller, newValue);
        return newValue;
      };
      case (?something) {
        let newValue = something + x;
        calculatedValues.put(caller, newValue);
        return newValue;
      };
    };
  };

  public shared ({ caller }) func sub(x : Float) : async Float {
    var oldValue = calculatedValues.get(caller);
    switch (oldValue) {
      case null {
        let newValue = -x;
        calculatedValues.put(caller, newValue);
        return newValue;
      };
      case (?something) {
        let newValue = something - x;
        calculatedValues.put(caller, newValue);
        return newValue;
      };
    };
  };

  public shared ({ caller }) func mul(x : Float) : async Float {
    var oldValue = calculatedValues.get(caller);
    switch (oldValue) {
      case null {
        return 0.0;
      };
      case (?something) {
        let newValue = something * x;
        calculatedValues.put(caller, newValue);
        return newValue;
      };
    };
  };

  public shared ({ caller }) func div(x : Float) : async ?Float {
    if (x == 0.0) {
      return null;
    };
    var oldValue = calculatedValues.get(caller);
    switch (oldValue) {
      case null {
        return null;
      };
      case (?something) {
        let newValue = something / x;
        calculatedValues.put(caller, newValue);
        return ?newValue;
      };
    };
  };

  public shared ({ caller }) func reset() : async () {
    calculatedValues.put(caller, 0.0);
    return ();
  };

  public query ({ caller }) func see() : async ?Float {
    return calculatedValues.get(caller);
  };

  public shared ({ caller }) func power(x : Float) : async Float {
    var oldValue = calculatedValues.get(caller);
    switch (oldValue) {
      case null {
        return 0;
      };
      case (?something) {
        // https://internetcomputer.org/docs/current/motoko/main/base/Float#function-pow
        let newValue = Float.pow(something, x);
        calculatedValues.put(caller, newValue);
        return newValue;
      };
    };
  };

  public shared ({ caller }) func sqrt() : async Float {
    var oldValue = calculatedValues.get(caller);
    switch (oldValue) {
      case null {
        return 0;
      };
      case (?something) {
        // https://internetcomputer.org/docs/current/motoko/main/base/Float#function-pow
        let newValue = Float.sqrt(something);
        calculatedValues.put(caller, newValue);
        return newValue;
      };
    };
  };

  public shared ({ caller }) func floor() : async Float {
    var oldValue = calculatedValues.get(caller);
    switch (oldValue) {
      case null {
        return 0;
      };
      case (?something) {
        // https://internetcomputer.org/docs/current/motoko/main/base/Float#function-pow
        let newValue = Float.floor(something);
        calculatedValues.put(caller, newValue);
        return newValue;
      };
    };
  };
};

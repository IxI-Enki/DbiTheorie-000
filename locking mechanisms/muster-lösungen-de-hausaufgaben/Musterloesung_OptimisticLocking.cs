// ALTER TABLE konto ADD version NUMBER DEFAULT 0;
 
// Optimistic locking
static bool TransferMoney(OracleConnection oc, int source, int dest, int amount) {
    OracleTransaction txn = oc.BeginTransaction();
    try {
        OracleCommand cmd = oc.CreateCommand();
        
        // Kontostand (=READ-Operation von Read-Modify-Write) und Version von Quell-Konto lesen
        int sourceBalance = -1;
        int sourceVersion = -1;
        cmd.CommandText = "SELECT balance, version FROM konto WHERE kid="+source;
        OracleDataReader reader = cmd.ExecuteReader();
        if(reader.Read()) {
            sourceBalance = reader.GetInt32(0);
            sourceVersion = reader.GetInt32(1);
        } else {
            throw new Exception("invalid source konto specified: "+source);
        }
        reader.Close();

        // Version von Ziel-Konto lesen (könnte ja zeitgleich als Ziel-Konto von jemand anders verwendet werden
        int destVersion = -1;
        cmd.CommandText = "SELECT version FROM konto WHERE kid="+dest;
        reader = cmd.ExecuteReader();
        if(reader.Read()) {
            destVersion = reader.GetInt32(0);
        } else {
            throw new Exception("invalid source konto specified: "+source);
        }
        reader.Close();

        if(sourceBalance < 0) {
            throw new Exception("source balance may ont become negative");
        }
        
        // Neuen Kontostand des Quell-Kontos im C#-Code berechnen (MODIFY)
        int newBalance = CalculateNewBalance(sourceBalance, amount);

        if(newBalance > 0) {
            // Neuen Kontostand des Quell-Kontos schreiben (WRITE), nur wenn die aktuelle Version der gelesenen entspricht
            cmd.CommandText = "UPDATE konto SET balance = " + newBalance +", version=version+1 WHERE kid="+source+" AND version="+sourceVersion;
            int modifiedRows = cmd.ExecuteNonQuery();
            if(modifiedRows == 0) {
                throw new Exception("lost update occured");
            }
            
            // Neuen Kontostand des Ziel-Kontos
            cmd.CommandText = "UPDATE konto SET balance = balance + " + amount +", version=version+1 WHERE kid="+dest+" AND version="+destVersion;
            modifiedRows = cmd.ExecuteNonQuery();
            if(modifiedRows == 0) {
                throw new Exception("lost update occured");
            }

            txn.Commit();
            return true;
        }
    }catch(Exception e) {
        Console.WriteLine(e.Message);
    }
    
    txn.Rollback();
    return false;
}

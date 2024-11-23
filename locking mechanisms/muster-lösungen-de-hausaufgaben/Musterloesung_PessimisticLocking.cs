
        static bool TransferMoney(OracleConnection oc, int source, int dest, int amount) {
            OracleTransaction txn = oc.BeginTransaction();
            try {
                OracleCommand cmd = oc.CreateCommand();
                
                // Lösung mittels Table-Lock:
                //cmd.CommandText = "LOCK TABLE konto IN EXCLUSIVE MODE";
                
                // Lösung mittels Row-Locks
                cmd.CommandText = "SELECT kid FROM konto WHERE kid IN ("+source+","+dest+") FOR UPDATE";
                cmd.ExecuteNonQuery();

                int sourceBalance = -1;
                cmd.CommandText = "SELECT balance FROM konto WHERE kid="+source;
                OracleDataReader reader = cmd.ExecuteReader();
                if(reader.Read()) {
                    sourceBalance = reader.GetInt32(0);
                } else {
                    throw new Exception("invalid source konto specified: "+source);
                }
                reader.Close();


                if(sourceBalance < 0) {
                    throw new Exception("source balance may ont become negative");
                }
                
                int newBalance = CalculateNewBalance(sourceBalance, amount);

                if(newBalance > 0) {
                    // Neuen Kontostand des Quell-Kontos schreiben (WRITE)
                    cmd.CommandText = "UPDATE konto SET balance = " + newBalance +" WHERE kid="+source;
                    cmd.ExecuteNonQuery();
                    // Neuen Kontostand des Ziel-Kontos
                    cmd.CommandText = "UPDATE konto SET balance = balance + " + amount +" WHERE kid="+dest;
                    cmd.ExecuteNonQuery();

                    txn.Commit();
                    return true;
                }
            }catch(Exception e) {
                Console.WriteLine(e.Message);
            }
            txn.Rollback();

            return false;
        }

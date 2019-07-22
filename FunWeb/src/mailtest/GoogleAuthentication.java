package mailtest;
import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class GoogleAuthentication extends Authenticator {
	PasswordAuthentication passAuth;
    
    public GoogleAuthentication(){
        passAuth = new PasswordAuthentication("fhdgofhdgo", "wstpyldmnicjgtxs");
    }
 
    public PasswordAuthentication getPasswordAuthentication() {
        return passAuth;
    }
}

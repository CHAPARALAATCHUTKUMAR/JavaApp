import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;

public class JavaAppTest {

    @Test
    public void testHomeEndpoint() {
        JavaApp javaApp = new JavaApp();
        String result = javaApp.home();
        assertEquals("index", result);
    }
}

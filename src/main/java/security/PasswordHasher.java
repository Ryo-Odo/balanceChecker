package security;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.spec.InvalidKeySpecException;
import java.util.Base64;

import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;

public final class PasswordHasher {
	private static final String PREFIX = "pbkdf2_sha256";
	private static final int ITERATIONS = 210_000;
	private static final int SALT_BYTES = 16;
	private static final int HASH_BITS = 256;
	private static final SecureRandom RANDOM = new SecureRandom();

	private PasswordHasher() {
	}

	public static String hash(String password) {
		if (password == null || password.isEmpty()) {
			throw new IllegalArgumentException("Password must not be empty.");
		}

		byte[] salt = new byte[SALT_BYTES];
		RANDOM.nextBytes(salt);
		byte[] hash = derive(password.toCharArray(), salt, ITERATIONS);

		return String.join("$", PREFIX, String.valueOf(ITERATIONS),
				Base64.getEncoder().encodeToString(salt), Base64.getEncoder().encodeToString(hash));
	}

	public static boolean verify(String password, String storedPassword) {
		if (password == null || storedPassword == null) {
			return false;
		}

		if (!isHashed(storedPassword)) {
			return MessageDigest.isEqual(password.getBytes(java.nio.charset.StandardCharsets.UTF_8),
					storedPassword.getBytes(java.nio.charset.StandardCharsets.UTF_8));
		}

		try {
			String[] parts = storedPassword.split("\\$", -1);
			int iterations = Integer.parseInt(parts[1]);
			byte[] salt = Base64.getDecoder().decode(parts[2]);
			byte[] expected = Base64.getDecoder().decode(parts[3]);
			byte[] actual = derive(password.toCharArray(), salt, iterations);
			return MessageDigest.isEqual(expected, actual);
		} catch (IllegalArgumentException e) {
			return false;
		}
	}

	public static boolean isHashed(String storedPassword) {
		return storedPassword != null && storedPassword.startsWith(PREFIX + "$")
				&& storedPassword.split("\\$", -1).length == 4;
	}

	private static byte[] derive(char[] password, byte[] salt, int iterations) {
		PBEKeySpec spec = new PBEKeySpec(password, salt, iterations, HASH_BITS);
		try {
			return SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256").generateSecret(spec).getEncoded();
		} catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
			throw new IllegalStateException("Password hashing is unavailable.", e);
		} finally {
			spec.clearPassword();
		}
	}
}

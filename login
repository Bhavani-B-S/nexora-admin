
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>NEXORA Admin Login</title>
  <style>
    * { box-sizing: border-box; }
    body {
      margin: 0; min-height: 100vh; display: grid;
      place-items: center; background: #080e1c;
      color: white; font-family: Arial, sans-serif; padding: 20px;
    }
    .card {
      width: 100%; max-width: 400px; padding: 30px;
      background: #151f35; border-radius: 16px;
    }
    h1 { color: #38bdf8; }
    label { display: block; margin: 18px 0 7px; }
    input {
      width: 100%; padding: 12px; border-radius: 8px;
      border: 1px solid #40506e; background: #080e1c;
      color: white; font-size: 15px;
    }
    button {
      width: 100%; padding: 13px; margin-top: 22px;
      border: 0; border-radius: 8px; background: #38bdf8;
      font-weight: bold; cursor: pointer;
    }
    #message { line-height: 1.5; overflow-wrap: anywhere; }
  </style>
</head>
<body>
  <div class="card">
    <h1>NEXORA</h1>
    <p>Administrator Login</p>

    <form id="loginForm">
      <label for="email">Email Address</label>
      <input id="email" type="email" required autocomplete="username">

      <label for="password">Password</label>
      <input id="password" type="password" required
             autocomplete="current-password">

      <button id="loginBtn" type="submit">Sign In</button>
      <p id="message" role="status"></p>
    </form>
  </div>

  <script type="module">
    import { initializeApp } from
      "https://www.gstatic.com/firebasejs/10.12.2/firebase-app.js";
    import { getAuth, signInWithEmailAndPassword } from
      "https://www.gstatic.com/firebasejs/10.12.2/firebase-auth.js";

    const firebaseConfig = {
      apiKey: "PASTE_API_KEY_HERE",
      authDomain: "PASTE_AUTH_DOMAIN_HERE",
      projectId: "nexora-digi-solutions",
      storageBucket: "PASTE_STORAGE_BUCKET_HERE",
      messagingSenderId: "PASTE_MESSAGING_SENDER_ID_HERE",
      appId: "PASTE_APP_ID_HERE"
    };

    const form = document.getElementById("loginForm");
    const message = document.getElementById("message");
    const button = document.getElementById("loginBtn");

    const configured = Object.values(firebaseConfig).every(
      value => value && !value.startsWith("PASTE_")
    );

    if (!configured) {
      message.textContent =
        "Setup required: add your Firebase web app configuration.";
      message.style.color = "#fbbf24";
      button.disabled = true;
    } else {
      const app = initializeApp(firebaseConfig);
      const auth = getAuth(app);

      form.addEventListener("submit", async event => {
        event.preventDefault();
        button.disabled = true;
        message.textContent = "Signing in...";

        try {
          await signInWithEmailAndPassword(
            auth,
            document.getElementById("email").value.trim(),
            document.getElementById("password").value
          );
          window.location.href = "admin.html";
        } catch (error) {
          message.textContent =
            "Login failed. Check your email and password.";
          message.style.color = "#fca5a5";
          button.disabled = false;
        }
      });
    }
  </script>
</body>
</html>

# Ethereal Emerald 💎

A volumetric raymarching exploration focused on deep emerald tones and organic, breathing motion.

### 🔬 Technical Highlights
* **Volumetric Accumulation:** Uses a 100-step loop to accumulate color density based on distance, creating a glowing, ethereal atmosphere.
* **Dynamic Rotation:** Implements a 2D rotation matrix (`mat2`) that evolves with time and depth, giving the visual its swirling, hypnotic effect.
* **Breathe Function:** Features a sine-driven "breathing" variable that modulates the scene's spatial scale in real-time.
* **Post-Processing:** Uses `tanh` for soft-clipping high brightness values and a power function for gamma correction, ensuring the greens look deep and saturated.

### 🛠 Tools
* **Language:** GLSL (OpenGL Shading Language)
* **Environment:** Shadertoy / WebGL

### 🔗 Live Demo
View the animated version on my [Shadertoy Profile](https://www.shadertoy.com/user/nostalgic_future).

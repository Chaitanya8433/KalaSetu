# KalaSetu

### Helping artisans take their craft online, one product at a time.

KalaSetu is a mobile app prototype built to make it easier for artisans
to showcase and sell their handmade products online.

The idea is simple: an artisan should not have to worry about writing
long product descriptions, editing photos, or understanding complicated
digital tools. They can simply take a photo, speak about their product,
and let KalaSetu handle the technical part.

## What KalaSetu Can Do

- 📸 Take or upload a photo of a handmade product
- 🎙️ Add product information using voice
- 🤖 Identify the product using AI
- 🖼️ Remove the background from product images
- 🛍️ Create a simple digital product listing
- 🌐 Prepare the product for future e-commerce integration

## How It Works

KalaSetu is designed to keep the process simple for artisans. 
The artisan provides a photo of the product and can describe it using their own voice. 
The system then processes this information and prepares it for digital selling.

### 1. Artisan Provides the Input

The process starts with two simple inputs:

- 📸 **Product Photo** — The artisan takes a photo of their handmade product.
- 🎙️ **Voice Description** — The artisan can describe the product in their local language instead of typing everything manually.

### 2. Cleaning the Product Image

The product photo is processed using **RMBG / BiRefNet** to remove the background.

This gives the product a cleaner image that can be used for online catalogues and product listings.

### 3. Converting Voice into Text

The voice description is processed using the **Bhashini ULCA API**.

The spoken information is converted into text while supporting multiple Indian languages.

### 4. AI Understands the Product

The cleaned image and the transcribed text are then processed using **Llama-3.1**.

The AI can help generate important product information such as:

- Product title
- Product description
- Key product attributes
- Suggested HSN code

The idea is to reduce the amount of manual work an artisan has to do.

### 5. Creating Structured Product Data

The generated information is organised into a standard **JSON format**.

It contains details such as:

- Product title
- Description
- Key attributes
- HSN code
- Product image URL

Keeping the information in a structured format makes it easier to connect KalaSetu with digital commerce platforms.

### 6. Ready for Digital Selling

The final information can be used to create a standardised product listing for e-commerce and marketplace platforms.

### The Complete Flow

**Product Photo + Voice Description**  
→ **Image & Voice Processing**  
→ **Clean Image + Transcribed Text**  
→ **AI Processing**  
→ **Structured Product Data**  
→ **Marketplace-Ready Listing**

### In Simple Words

> **An artisan simply shares a photo and talks about their product in their own language. KalaSetu takes care of the technical work and turns that information into a digital-ready product listing.**

## Technology

### Current Prototype

- **Flutter & Dart** — Used to build the working mobile app prototype
- **Gemini Vision** — Used for product identification
- **Background Removal API** — Used to clean product images
- **Speech-to-Text** — Used for voice-based input
- **REST APIs** — Used to connect the app with external services

### Planned Production Version

- **Kotlin** — Proposed native Android application layer
- **Llama** — Planned for generating product catalogue content
- **FastAPI** — Planned backend/API layer
- **Firebase** — Planned cloud storage and backend services
- **ONDC** — Planned marketplace integration

## Project Status

KalaSetu is currently a working prototype developed as an academic
and innovation project.

The current version focuses on the core experience of helping an
artisan turn a product photo and basic information into a
digital-ready product listing.

More marketplace and backend features can be added as the project
moves towards a production version.

## Our Goal

We want to make digital selling simple enough that an artisan can
focus on what they do best — **creating their craft** — while KalaSetu
takes care of the complicated digital work.

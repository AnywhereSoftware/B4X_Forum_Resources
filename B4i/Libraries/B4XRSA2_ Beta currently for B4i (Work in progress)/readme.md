### B4XRSA2: Beta currently for B4i (Work in progress) by b4x-de
### 05/13/2026
[B4X Forum - B4i - Libraries](https://www.b4x.com/android/forum/threads/171001/)

I would like to use this thread to discuss a possible replacement for [ICODE]iRSA[/ICODE] on B4i and to invite feedback before I continue with the next steps.  
  
If you currently use [ICODE]iRSA[/ICODE], or if you have B4i code that depends on RSA encryption / decryption, I would be very interested in:  
  

- feedback on the API direction
- feedback on compatibility expectations
- real-world PEM test material
- beta-test feedback on B4i

  
This is **not** intended as a final polished release post yet. It is a work-in-progress beta thread and a proposal for how these problems could be addressed.  
  
**What I am trying to solve**  
  
This project currently has two goals:  
  

- replace the outdated [ICODE]iRSA[/ICODE] library for B4i
- keep the old [ICODE]iRSA[/ICODE]-style API available for existing code
- offer a cleaner modern API for new code

  
Current status of this beta:  
  

- Platform status: B4i only for now
- State: work in progress
- Focus of this beta: explain the overall direction and illustrate the current B4i implementation

  
**Why I think iRSA should be replaced**  
  
The old [ICODE]iRSA[/ICODE] library was useful for its time, but I no longer think it is a good foundation for new work.  
  
The reasons are both practical and technical:  
  

- [ICODE]iRSA[/ICODE] itself is not an original RSA implementation. In the original B4X library thread it is explicitly described as a wrapper around the GitHub project [ICODE]Objective-C-RSA[/ICODE].
- The original B4X thread around [ICODE]iRSA[/ICODE] already raised concerns about key size support.
- In the [ICODE]iRSA[/ICODE] thread Erel explicitly stated on February 14, 2019 that the underlying library does not support 2048 / 4096-bit keys.
- In later B4i RSA support discussions, users explicitly pointed out that [ICODE]iRSA[/ICODE] does not provide a proper signing API and is not a good cross-platform answer anymore.
- The old library is also highly sensitive to PEM and key container details such as [ICODE]PUBLIC KEY[/ICODE], [ICODE]RSA PUBLIC KEY[/ICODE], [ICODE]PRIVATE KEY[/ICODE] and [ICODE]RSA PRIVATE KEY[/ICODE].
- And more recently, the new B4i 10 builder and library pipeline exposed that [ICODE]iRSA[/ICODE] is also a problematic dependency operationally, not only cryptographically.

  
There is also a maintenance concern behind this:  
  

- The wrapped GitHub project [ICODE]ideawu/Objective-C-RSA[/ICODE] appears to have been quiet for years.
- The repository currently shows only a small commit history and no published releases.
- That does not automatically mean it is broken, but for security-sensitive code it is not a comfortable long-term basis.

  
And there is a platform API concern as well:  
  

- Apple documents the old [ICODE]SecKeyEncrypt[/ICODE] / [ICODE]SecKeyDecrypt[/ICODE] functions as deprecated and points developers to [ICODE]SecKeyCreateEncryptedData[/ICODE] / [ICODE]SecKeyCreateDecryptedData[/ICODE].
- Apple also documents [ICODE]SecKeyRawSign[/ICODE] / [ICODE]SecKeyRawVerify[/ICODE] as deprecated in favor of [ICODE]SecKeyCreateSignature[/ICODE] / [ICODE]SecKeyVerifySignature[/ICODE].
- So even before talking about RSA semantics, key sizes, or interoperability, the old Objective-C code path is built around APIs that Apple itself has moved away from.

  
While working on this beta I also built a dedicated B4i test suite and boundary investigation. That confirmed an important point:  
  
[INDENT]the new library can be made stable on modern iOS APIs, but the old [ICODE]iRSA[/ICODE] library itself is not a fully reliable gold standard for every historical operation direction.[/INDENT]  
  
**Why I am starting with a B4XLib**  
  
At this stage I intentionally want to publish this as a [ICODE].b4xlib[/ICODE], even though the old library it is meant to replace was delivered as a native library.  
  
There are two reasons for that:  
  

- from a B4X distribution perspective, source-based B4X libraries are a better fit for this kind of reusable library
- from a B4i build-pipeline perspective, the old legacy native [ICODE]iRSA[/ICODE] setup has become increasingly awkward in the newer builder flow

  
The second point matters more than it might seem:  
  

- In December 2025 there was already a report that the new hosted builder in B4i 10.00 was missing [ICODE]iRSA[/ICODE] completely until it was manually uploaded.
- In May 2026 there was a follow-up report showing that a normal B4i app build could still work with legacy [ICODE]iRSA[/ICODE], while [ICODE]Compile To Library[/ICODE] failed because [ICODE]libtool[/ICODE] could not resolve [ICODE]-liRSA[/ICODE].
- There was also a larger builder discussion around long or fragile B4i build flows, where Erel explicitly suggested compiling parts of large projects as libraries.

  
So one practical goal of this project is not only to replace an outdated RSA API, but also to move away from a fragile legacy [ICODE].a[/ICODE]-style dependency and toward a B4X-friendly library format.  
  
There is also an important architectural point from the B4X forum:  
  
[INDENT]Erel wrote in the duplicate-b4xlib discussion that native libraries should not reference b4xlibs because this is an inherent limitation of how b4xlibs work.[/INDENT]  
  
For this beta that leads me to a simple conclusion:  
  

- do not create yet another legacy native [ICODE]iRSA[/ICODE]-style wrapper as the main delivery format
- deliver the reusable library itself as a [ICODE].b4xlib[/ICODE]
- keep the native iOS-specific implementation inside the project where needed, but publish the library in the format that best matches current B4X usage

  
**What this beta currently provides**  
  
Right now the beta contains two facades:  
  

- [ICODE]B4XRsa[/ICODE] for backward compatibility with the old [ICODE]iRSA[/ICODE]-style API
- [ICODE]B4XRsa2[/ICODE] for a clearer modern API

  
**Legacy API compatibility**  
  
My first goal was to preserve the old four-method API shape:  
  

```B4X
Dim rsaLegacy As B4XRsa  
Dim plain() As Byte  
Dim cipher() As Byte  
Dim restored() As Byte  
  
rsaLegacy.Initialize  
plain = "Hello legacy RSA".GetBytes("UTF8")  
  
cipher = rsaLegacy.EncryptWithPublicKey(plain, PublicKeyPem)  
restored = rsaLegacy.DecryptWithPrivateKey(cipher, PrivateKeyPem)  
  
Log(BytesToString(restored, 0, restored.Length, "UTF8"))
```

  
  
That means existing code using:  
  

- [ICODE]EncryptWithPublicKey[/ICODE]
- [ICODE]DecryptWithPrivateKey[/ICODE]
- [ICODE]EncryptWithPrivateKey[/ICODE]
- [ICODE]DecryptWithPublicKey[/ICODE]

  
can potentially be moved to the new library without first rewriting the public call shape.  
  
**Limits of the old API and why I still think a new API is needed**  
  
The legacy API remains available because compatibility matters. But it should also be clear why it is not ideal as the future-facing API:  
  

- [ICODE]EncryptWithPrivateKey[/ICODE] and [ICODE]DecryptWithPublicKey[/ICODE] are legacy operations with awkward semantics.
- They are often confused with real signing and verification.
- The historical [ICODE]iRSA[/ICODE] behavior is not stable enough to treat every legacy path as a normative modern contract.
- The old library is also limited by key size support and format sensitivity.

  
That is exactly why this beta also introduces a cleaner API.  
  
**Modern API example**  
  

```B4X
Dim rsa As B4XRsa2  
Dim plain() As Byte  
Dim cipher() As Byte  
Dim restored() As Byte  
Dim signature() As Byte  
Dim verified As Boolean  
  
rsa.Initialize  
plain = "Hello modern RSA".GetBytes("UTF8")  
  
cipher = rsa.EncryptWithPublicKey(plain, PublicKeyPem)  
restored = rsa.DecryptWithPrivateKey(cipher, PrivateKeyPem)  
  
signature = rsa.Sign(plain, PrivateKeyPem)  
verified = rsa.Verify(plain, signature, PublicKeyPem)  
  
Log(BytesToString(restored, 0, restored.Length, "UTF8"))  
Log("Verified = " & verified)
```

  
  
The idea is simple:  
  

- use [ICODE]B4XRsa[/ICODE] when you need drop-in compatibility
- use [ICODE]B4XRsa2[/ICODE] for new code

  
**Current scope of version 0.5 Beta**  
  
This beta is intentionally limited:  
  

- B4i only
- native implementation based on modern iOS Security APIs
- legacy compatibility facade included
- modern Encrypt / Decrypt and Sign / Verify included
- work on B4A and B4J would come later, after the B4i behavior is considered stable enough

  
**Important note about compatibility claims**  
  
The goal is backward compatibility of the public API and practical migration support.  
  
However, based on both the forum history and the current boundary tests, [ICODE]iRSA[/ICODE] itself should not be treated as an unrestricted reference for:  
  

- 2048 / 4096-bit coverage
- real Sign / Verify semantics
- all private/public legacy directions

  
So the current proposal is to keep the old surface where that helps users, while also documenting where the old library itself has technical limits.  
  
**Relevant background threads**  
  

- [iRSA - RSA encryption / decryption](https://www.b4x.com/android/forum/threads/irsa-rsa-encryption-decryption.83477/)
- [RSA support in B4i](https://www.b4x.com/android/forum/threads/rsa-support-in-b4i.120966/)
- [RSA wrapper needed (B4i)](https://www.b4x.com/android/forum/threads/rsa-wrapper-needed-b4i.138294/)
- [B4X RSA Encrypt and Decrypt](https://www.b4x.com/android/forum/threads/b4x-rsa-encrypt-and-decrypt.104065/)
- [Hosted Builder in Version 10.00 is missing iRSA-Lib](https://www.b4x.com/android/forum/threads/hosted-builder-in-version-10-00-is-missing-irsa-lib.169669/#post-1039217)
- [Compile To Library fails with legacy iRSA library, while normal app build works on B4i 10.00](https://www.b4x.com/android/forum/threads/compile-to-library-fails-with-legacy-irsa-library-while-normal-app-build-works-on-b4i-10-00.170996/#post-1046439)
- [Hosted Builder reports Error: BUILD INTERRUPTED on a large B4i project](https://www.b4x.com/android/forum/threads/hosted-builder-reports-error-build-interrupted-on-a-large-b4i-project.170904/post-1046436)
- [How to handle duplicate b4xlib dependencies in compiled native libraries?](https://www.b4x.com/android/forum/threads/how-to-handle-duplicate-b4xlib-dependencies-in-compiled-native-libraries.170958/post-1046238)
- [Objective-C-RSA on GitHub](https://github.com/ideawu/Objective-C-RSA)
- [Apple documentation for deprecated SecKeyEncrypt](https://developer.apple.com/documentation/security/seckeyencrypt%28_%3A_%3A_%3A_%3A_%3A_%3A%29)
- [Apple documentation for deprecated SecKeyDecrypt](https://developer.apple.com/documentation/security/seckeydecrypt%28_%3A_%3A_%3A_%3A_%3A_%3A%29)

  
**Attachments for beta testing**  
  

- [ICODE]B4XRSA2.b4xlib[/ICODE]
- [ICODE]B4XRSA2-b4i-beta-example.zip[/ICODE]

  
**Feedback welcome**  
  
If you would like to try this beta on B4i, I would especially appreciate:  
  

- migration feedback from existing [ICODE]iRSA[/ICODE] users
- interop feedback with real PEM material
- opinions on the modern API shape before B4A / B4J are added
- beta-test feedback from anyone willing to try the attached B4i 0.5 work in progress
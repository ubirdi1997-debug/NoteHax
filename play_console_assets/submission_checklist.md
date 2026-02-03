# Google Play Console Submission Checklist

## Pre-Submission Requirements

### 1. App Basics
- [x] App is built and tested
- [x] App icon (ic_launcher) is set up in all densities
- [x] App is signed with release key (key.jks)
- [x] App Bundle (AAB) is generated
- [ ] App has been tested on multiple devices and Android versions

### 2. Store Listing Content

#### Required Items:
- [x] App title (max 50 characters): "NoteHax - Smart Notes & Secure Vault"
- [x] Short description (max 80 characters)
- [x] Full description (max 4000 characters)
- [ ] App icon (512x512 PNG)
- [ ] Feature graphic (1024x500 PNG or JPEG)
- [ ] Screenshots (2-8 phone screenshots, 1080x1920 recommended)
- [ ] Privacy Policy URL (https://yourwebsite.com/privacy.html)

#### Optional but Recommended:
- [ ] Tablet screenshots
- [ ] Promo video (YouTube URL)
- [ ] TV banner (if Android TV support)

### 3. Content Rating
- [ ] Complete IARC questionnaire
- [ ] Verify rating: Everyone (no violence, mature content)

### 4. App Content
- [x] Privacy Policy URL provided
- [ ] Ads declaration (This app: No ads ✅)
- [ ] In-app purchases declaration (This app: None ✅)
- [ ] Target audience age range: 13+
- [ ] Content labels applied

### 5. Pricing & Distribution
- [ ] Set pricing (Free or Paid)
- [ ] Select countries for distribution
- [ ] Confirm export compliance
- [ ] Review app availability

---

## Detailed Setup Steps

### Step 1: Create App in Play Console

1. Log in to Google Play Console
2. Click "Create App"
3. Fill in details:
   - **App name**: NoteHax
   - **Default language**: English (US)
   - **App or game**: App
   - **Free or paid**: Free (or your choice)
4. Accept declarations
5. Click "Create app"

### Step 2: Store Listing

Navigate to: **Store presence → Main store listing**

#### Required Fields:

**App name**: NoteHax - Smart Notes & Secure Vault

**Short description**:
```
Smart note-taking with encryption, voice notes, OCR scanning & time capsules
```

**Full description**: 
See `store_listing.md` file in play_console_assets folder

**App icon**: 
- Upload 512x512 PNG version of your logo
- Must be high-quality, no transparency in center
- Follow Material Design guidelines

**Feature graphic**:
- Create 1024x500 graphic
- Include app icon, name, and key features
- Use brand colors (neon blue/green)

**Screenshots**:
- Take 4-8 screenshots of app
- 1080x1920 resolution recommended
- Show key features: home, editor, security, search
- See `screenshot_requirements.md` for details

**Contact details**:
- Email: notehax.aarav@gmail.com
- Website: (if available)
- Phone: (optional)

**Privacy Policy**:
- URL: https://yourwebsite.com/privacy.html
- Must be publicly accessible
- Use the privacy.html file created in web folder

### Step 3: App Content

Navigate to: **Policy → App content**

#### Data Safety Section
1. Click "Start"
2. Answer questions about data collection:
   - **Does your app collect or share user data?** Yes (for local storage)
   - **Data types collected**:
     - Files and docs (notes content)
     - App activity (usage data - local only)
   - **Is data encrypted in transit?** No (offline app)
   - **Can users request data deletion?** Yes (delete notes in app)
3. Data handling:
   - All data stored locally
   - No third-party sharing
   - No data sent to servers

#### Privacy Policy
- Enter URL: https://yourwebsite.com/privacy.html

#### Ads
- Select: **No, my app does not contain ads**

#### Content Ratings
1. Click "Start questionnaire"
2. Select category: **Utilities & Productivity**
3. Answer questions:
   - Violence: No
   - Sexual content: No
   - Language: None
   - Controlled substances: No
   - Gambling: No
4. Submit and receive rating (likely "Everyone")

#### Target Audience
1. Age groups: **13 and older**
2. Appeal to children: **No**

#### News App
- Select: **No**

#### COVID-19 Contact Tracing and Status Apps
- Select: **No**

#### Data safety
- Complete as described above

#### Government Apps
- Select: **No** (unless applicable)

### Step 4: Release Setup

Navigate to: **Release → Production → Create new release**

#### Version Information
- Version name: 1.0.0
- Version code: 1 (auto-filled from AAB)

#### Upload App Bundle
1. Click "Upload"
2. Select `app-release.aab` file
3. Wait for processing
4. Review any warnings/errors

#### Release Notes
```
Initial Release - Version 1.0.0

Welcome to NoteHax! 

New Features:
• Smart note-taking with auto-detection
• Secure vault with encryption
• Voice notes and OCR scanning
• Time capsule notes
• Offline-first design
• No ads, no tracking

See full details in the app description.
```

### Step 5: Countries and Regions

1. Select **Available** for countries where you want to distribute
2. Or select **Add countries/regions** and choose specific ones
3. Recommended: Start with few countries, expand later

### Step 6: Pricing

- **Pricing**: Free (recommended for v1.0)
- **In-app products**: None (for now)
- Can change to paid later if needed

### Step 7: App Access

- Most apps: **All functionality is available without restrictions**
- If login required: Provide test credentials

### Step 8: Ads Declaration

- Select: **No, my app does not contain ads**

---

## Pre-Launch Checklist

Before clicking "Start rollout to Production":

- [ ] All required content is uploaded
- [ ] Privacy policy URL is live and accessible
- [ ] Feature graphic looks good in preview
- [ ] Screenshots are clear and represent app accurately
- [ ] App description has no typos
- [ ] Content rating is appropriate
- [ ] App Bundle uploaded successfully
- [ ] Release notes written
- [ ] Countries selected
- [ ] Pricing set
- [ ] App access specified
- [ ] Test app on physical device one more time

---

## Internal Testing (Recommended First)

Before production release, test internally:

1. Navigate to: **Release → Testing → Internal testing**
2. Create new release
3. Upload same AAB
4. Add testers (email addresses)
5. Share testing link
6. Collect feedback
7. Fix issues
8. Move to production when ready

---

## Review Timeline

- **Internal testing**: Instant
- **Closed testing**: Instant
- **Open testing**: Usually instant
- **Production**: 1-3 days for first review
- **Updates**: Usually few hours to 1 day

---

## After Submission

### Monitor Your Release
1. Check **Release → Production** for status
2. Review any warnings in Play Console dashboard
3. Monitor crashes in **Quality → Android vitals**
4. Respond to user reviews promptly
5. Track downloads and ratings

### Update Your App
1. Increment version code and name
2. Build new AAB
3. Create new release in Play Console
4. Add release notes
5. Submit for review

---

## Common Issues and Solutions

### Issue: "Privacy Policy URL not accessible"
**Solution**: Ensure privacy.html is hosted on a publicly accessible URL

### Issue: "App icon not meeting requirements"
**Solution**: Use exactly 512x512 PNG, no transparency in center

### Issue: "Feature graphic rejected"
**Solution**: Use exactly 1024x500, PNG or JPEG, under 1MB

### Issue: "Rejected for permissions"
**Solution**: Declare all permissions in app content section

### Issue: "Data safety section incomplete"
**Solution**: Answer all questions, even if "No data collected"

---

## Support Resources

- **Play Console Help**: https://support.google.com/googleplay/android-developer
- **Developer Policies**: https://play.google.com/about/developer-content-policy/
- **Material Design Guidelines**: https://material.io/design
- **Flutter Deployment Guide**: https://flutter.dev/docs/deployment/android

---

## Contact for Issues

- **Play Console Support**: Via Play Console Help Center
- **Developer Community**: Stack Overflow, Reddit r/androiddev
- **App Support**: notehax.aarav@gmail.com

---

## Files Ready for Upload

Location: `/home/runner/work/NoteHax/NoteHax/play_console_assets/`

- ✅ store_listing.md - Full app description
- ✅ release_notes.md - What's new text
- ✅ categories_and_tags.md - ASO keywords
- ✅ screenshot_requirements.md - Guide for screenshots
- ✅ build_instructions.md - How to build APK/AAB
- ✅ submission_checklist.md - This file

AAB Location: `/home/runner/work/NoteHax/NoteHax/build/app/outputs/bundle/release/app-release.aab`

Privacy Policy: `/home/runner/work/NoteHax/NoteHax/web/privacy.html`

---

**Ready to Publish!** 🚀

Follow this checklist step by step, and your app will be live on Google Play Store soon!


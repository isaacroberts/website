const String ragnarFull = """
I built the backend for the project, including an efficient multi-threaded sample loader to load required subset of 10GB sample database.
I hired and managed the frontend developer & fixed frontend code when it needed it.
The sample library was 10 GB, but a user's machine can only hold 1 GB in memory, so I designed a sample loader to load only needed samples while keeping the audio thread at realtime speeds.
The client wanted the samples encrypted to prevent hackers from stealing samples, so I developed a fast sample encryption technique to keep audio thread realtime. 

""";

const String lemonaidFull = """
Lemonaid uses Google's Magenta machine learning library to generate melodies in JSON format based on arbitrary inputs.  
Due to changing requirements, I integrated the model clientside using Google's V8 and Javascript, and then integrated the model serverside using REST and a web API.
In addition, the client provided 1400 loose midi files to be used as the chord accompaniments, which I cleaned, sorted, and parsed into numerical constants in order to preserve the client's creative vision.
The plugin was such a hit that the client was invited to give talks at NYU and VCU on the machine learning used in the plugin. 
""";

const String mvFull = """
The default reverb from the JUCE library was too slow to handle the client's desired reverb, so I integrated a better reverb API with Apple and Intel FFT to preserve the client's creative vision.
In addition, the JUCE filters did not match the client's specification, so I integrated and rewrote another filter library to better match the intended sound. The filter library used extensive template metaprogramming, which I managed to preserve in the rewrite. 
For other components, the client had only vague specifications, leaving me to choose the best parameters and options by ear. 
In the end, the plugin was a hit, netting 30,000 views and 300 comments on the client's youtube channel.
""";

const String ottFull = """

""";

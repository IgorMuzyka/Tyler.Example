To try this out.

First go to the API directory and run in your terminal:

```bash
make update
make xcode
open -a Xcode .
```

Now **Build & Run** the **Run** scheme in current project.

Now go to the iOS directory and execute the following in your terminal:

```bash
pod install
open -a Xcode .
```

Note: if you encounter any problems at this stage you probably need to either update your local pod repo or the cocoapods itself.

You can run it on your iPhone or in Simulator, the ip address of the API is defined by a build phase.

Shake iPhone to fetch the same route once again from the network.
import 'package:flutter/material.dart';
import 'communication_screen.dart';

/*
This is the start screen for the application. It is mainly utilized for layout
of the start screen but does have a button for the user to click into the rest
of the communicator, the actual communication part of the application. In general,
this was created to list the title of the application but also explain how this
works and is to be used to the individuals using or those having the individual
utilize the application. We use some boxes to provide short descriptions too and
the button is pressed to begin the communication process.
 */

class StartScreen extends StatelessWidget {
  const StartScreen({super.key}); // constructor for the screen

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // this gives the main design structure of the application.
      backgroundColor: Colors.blue, // and sets the color to blue.
      body: SafeArea(
        // This is similar to padding but keeps the screen from
        child: Padding(
          // sides of the screens . Padding adds another layer too
          padding: EdgeInsets.symmetric(
            // keeps layout away from edges evenly
            horizontal: 28, // based on vertical or horizontal.
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(flex: 2), // pushes content down, better divider/ sized box

              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(
                    28,
                  ), // radius border is circular
                  boxShadow: [
                    // adds a backdrop type shadow to the boxes
                    BoxShadow(
                      color: Colors.black87,
                      blurRadius: 24,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: const Icon(
                  // Icon for large image of start screen
                  Icons.chat_rounded,
                  color: Colors.white,
                  size: 55,
                ),
              ),
              SizedBox(height: 28),
              Text(
                'Communicator Application', // title text of the application under
                style: TextStyle(
                  // the image of the app
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 28),
              Text(
                // Description of application under title and image.
                'Speaking has never been simpler, select '
                'images to communicate thoughts, feelings, '
                'wants, and needs. Your selections will be '
                'spoken aloud for all the hear!',
                style: TextStyle(fontSize: 16, color: Colors.black),
                textAlign: TextAlign.center,
              ),
              Spacer(flex: 2), // another spacer used to push down icons to
              // highlight the features of the application.
              Row(
                children: [
                  _DescriptionCard(
                    // description card layout with images, titles
                    icon: Icons
                        .image_outlined, // and short description of features.
                    title: 'Picture Cards',
                    subtitle: 'Used for understanding',
                  ),
                  SizedBox(width: 10),
                  _DescriptionCard(
                    icon: Icons.volume_up_outlined,
                    title: 'Text-to-Speech',
                    subtitle: 'Images spoken aloud',
                  ),
                  SizedBox(width: 10),
                  _DescriptionCard(
                    icon: Icons.touch_app_outlined,
                    title: 'Simple Design',
                    subtitle: 'Accessible and simple',
                  ),
                ],
              ),
              SizedBox(height: 28), // This is a sized box separator for the
              // description boxes and the button to start
              SizedBox(
                // the application.
                width: double.infinity,
                child: ElevatedButton(
                  // elevated button for communicator to
                  onPressed: () {
                    // activate. Titled start communicating
                    Navigator.of(context).pushReplacement(
                      // and navigates to
                      MaterialPageRoute(
                        // pages on pressed.
                        builder: (_) => const CommunicationScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Start Communicating',
                  ), // again, general layout of
                  style: ElevatedButton.styleFrom(
                    // start communicating button
                    backgroundColor: Colors.black87,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ), // Communicating button is different color to differentiate
                ), // it from the boxed descriptions to signal a press.
              ),
              SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }
}

/*
Method created for the description cards created under the title, logo, and
explanation of the application. Explaining it up here, we have teh variables
icon, title, and subtitle becasue the layout is to provide explanation to
users of the application or teachers of the applications, inclusive. Next,
we have the general layout of the row of images, utilizing rounde boxes with
shadowing under them to make them pop a bit more behind the blue background.
 */

class _DescriptionCard extends StatelessWidget {
  final IconData _icon;
  final String _title;
  final String _subtitle;

  const _DescriptionCard({
    required this._icon,
    required this._title,
    required this._subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(color: Colors.black, blurRadius: 8, offset: Offset(0, 2)),
          ],
        ),
        child: Column(
          children: [
            Icon(_icon, size: 40, color: Colors.white),
            SizedBox(height: 10),
            Text(
              _title,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4),
            Text(
              _subtitle,
              style: TextStyle(fontSize: 12, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

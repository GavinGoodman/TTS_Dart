import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/board_data.dart';
import '../models/communicator.dart';
import 'start_screen.dart';

/*
This is the main layout of the application along with how the boards will
traverse for users in the application. Summerizing this file is simple,
it is the one that provides the layout of the boards. We have the base boards,
inner categories, and the individual tiles. Additionally, we have the trash
button with an alert box, the sentence basr to store the words selected, the
speech button to get the tts to speak and the arrows. Those two arrows are
the exit which sets the user back to the start screen and the back for the
user to exit out of a category and return to the previous board list. Lastly,
it has a long press which will insert words and speak the category selections
as words as well.
 */

class CommunicationScreen extends StatefulWidget {
  const CommunicationScreen({super.key});

  // This creates a state that can be changed throughout the application process.
  @override
  State<CommunicationScreen> createState() => _CommunicationScreenState();
}

class _CommunicationScreenState extends State<CommunicationScreen> {
  List<List<BoardItemInfo>> _boardStack = [
    baseBoard,
  ]; // this is a "custom stack"
  // It is a list of lists to store navigation path of the to revert boards and
  // move forward in boards if a category is selected.

  // getter to retrieve the current board the app is on, root or in a category
  // also guarentees that the last board in the stack is the most recent viewed.
  List<BoardItemInfo> get _currentBoard => _boardStack.last;

  /*
  THis is used for the tile tap when using the device.
  The provider is set to context.read to not rebuild the widget when provider
  is changed throughout the application (it will change a bit). It will check
  first if tap is a category, if not it will move into the subtree boards and add
  it to the tree stacks
   */
  void _onTileTap(BoardItemInfo tile) {
    final provider = context.read<CommunicationProvider>();
    if (tile.isCategory) {
      setState(() {
        _boardStack.add(tile.subtree);
      });
    } else {
      // if it is not, it will add the word to the sentence bar and speak the word.
      provider.addWord(tile.label);
      provider.speakWord(tile.label);
    }
  }

  /*
  This is the longTap call which will allow a user to select category words to
  be spoken. This can also work for the general inner tree tiles as well. For this,
  we have context.read again for the provider but just add the word and speak it
  instead of checking for a category.
   */
  void _onTileLongPress(BoardItemInfo tile) {
    final provider = context.read<CommunicationProvider>();
    provider.addWord(tile.label);
    provider.speakWord(tile.label);
  }

  /*
  This is the function that utilizes the board stack to move back through the
  board levels while inside the category. First it will check to see if the
  stack length is greater than 1, and if so it will move back into the category.
  If it is not, the back button will not be present for the user to select.
   */
  void _goBack() {
    if (_boardStack.length > 1) {
      setState(() {
        _boardStack.removeLast();
      });
    }
  }

  /*
  Here is the hosted layout of the communication screens for the user to select
  amd speak some words. It will host the layout of the grid and columns along for
  the user to select the boards and categories. Additionally, it will host the
  sentence bar for the words input by the user to be stored and seen while
  being spoken at that time. It will also have the exit arrow on the left to
  return to the start screen while having the back arrow on the right when a
  user is within a category of the grid and wants to return one category board.
  We also have a few buttons in the GUI as well, the one at the top being the
  speaker button to play to words in the sentence bar, and another one at the
  bottom right being the trashcan button to clear the sentence menu. Lastly,
  this trash button will pop up an alert box to clear or cancel for the user as well.
  I will provide more details as short in-line comments as well.
   */
  @override
  Widget build(BuildContext context) {
    bool isAtRoot =
        _boardStack.length == 1; // boolean to determine if device is
    // at the root board.
    return PopScope(
      // utilized in order to have a back button approach to the
      canPop: isAtRoot, // device. Here it acts as a check and if the root is
      onPopInvokedWithResult: (didPop, result) {
        // present, the screen acts as
        if (!didPop)
          _goBack(); // normal due to not needing to go back. If didPop
      }, // is false, it allows the user to go back one board and essentially leave
      child: Scaffold(
        // the category. Rest is general layout of board screen
        backgroundColor: Colors.blue,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: TextButton.icon(
            onPressed: () {
              // here is on pressed call, this one is utilized for
              Navigator.of(context).pushReplacement(
                // the exit arrow selection
                MaterialPageRoute(
                  builder: (_) => StartScreen(),
                ), // and navigates
              ); // the user back to the start screen once pressed.
            },
            icon: Icon(
              Icons.arrow_back,
              size: 14,
              color: Colors.grey,
            ), // icon to press
            label: Text(
              'Exit',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
          leadingWidth:
              80, // utilized to give arrow and exit text enough room to show
          title: Text(
            // both back to back.
            'Communicate',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          actions: [
            if (!isAtRoot)
              TextButton.icon(
                // This will be the utilization of the PopScope partly,
                onPressed:
                    _goBack, // if not on the root board, it will allow the
                icon: Icon(
                  // user to see a blue go back button to be pressed. This
                  Icons
                      .arrow_back, // will navigate to the previous board screen,
                  size: 16, // leaving the category and returning to the root in
                  color: Colors
                      .blueAccent, // most cases. Backs board stack up one.
                ),
                label: Text(
                  'Back',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
        body: Column(
          children: [
            _SentenceMenu(), // Called to show words in sentence menu user has
            // selected with ability to speak them if wanted.
            Divider(height: 1, thickness: 1, color: Colors.white),
            Expanded(
              child: AnimatedSwitcher(
                // This is a transisition in essence, barely
                duration: Duration(
                  milliseconds: 250,
                ), // seen but was similar to
                child: _BoardGrid(
                  // editing apps in my previous degree.
                  key: ValueKey(
                    _boardStack.length,
                  ), // helps track the changing of
                  items:
                      _currentBoard, // boards between categories when depth changes (stack).
                  onTap: _onTileTap, // Will pass current board information and
                  onLongPress: _onTileLongPress, // utilize the tap information
                ), // previously talked about. Single tap for entering categories
              ), // and adding single tiles to sentence menu while speaking them.
            ), // Long press will add words to menu and speak them including category tiles.
          ],
        ),
        // Utilized ony rebuild the trashcan to clear the bar instead of trying to
        // rebuild the entire screen with every call or trash press.
        floatingActionButton: Consumer<CommunicationProvider>(
          builder: (_, provider, __) {
            return FloatingActionButton(
              heroTag:
                  'clear', // hovering trash states purpose is to clear sentence
              backgroundColor:
                  Colors.grey, // The rest of this is color dependent
              foregroundColor:
                  provider
                      .isEmpty // if the sentence bar is empty, the
                  ? Colors
                        .black // icon will be black and if input, it will be red
                  : Colors.redAccent,
              elevation: 4,
              onPressed:
                  provider
                      .isEmpty // checks for an empty sentence menu
                  ? null // if empty, cannot be pressed but if filled at all, it
                  : () =>
                        _confirmClear(context, provider), // will call the clear
              child: Icon(
                // method, with a dialog box. The last color is the
                Icons.delete_forever, // same, changing based on if the sentence
                size: 28, // menu is empty or a word is input in the device.
                color: provider.isEmpty ? Colors.black : Colors.redAccent,
              ),
            );
          },
        ),
      ),
    );
  }

  void _confirmClear(BuildContext context, CommunicationProvider provider) {
    /*
    This is the dialog box utilize in the trashcan floating action button. Here
    we have a showDialog to open up a new box with information to clear the
    sentence or to cancel the selection via an alert box. Idea is to prevent an
    accidental deletion. In the alert box specifically, we will see a statement
    letting the user know this, if clear is selected, will remove all words from
    the sentence menu and the state will remain the same if cancel is selected.
     */
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        // alert dialog box call in show dialog.
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Clear?'),
        content: Text('This will remove all words from sentence.'),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.pop(context), // if cancel is clicked, the
            child: Text('Cancel'), // dialog box will close with no changes
          ),
          TextButton(
            onPressed: () {
              // second press for clear selection, this will call
              provider
                  .clearSentence(); // clear sentence method and clear the words.
              Navigator.pop(
                context,
              ); // It will then return the user to an empty
            }, // sentence menu. Selections are color coated for better accessibility
            child: Text('Clear', style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }
}

class _SentenceMenu extends StatelessWidget {
  const _SentenceMenu();
  /*
This is a custom sentence menu class to create and add functionality to the sentence
menu above the board to show the words selected and allow the user to speak the
full sentence as intended. This will rebuild the widget instead of restarting the
entire screen when a word is added or removed by the user.
 */
  @override
  Widget build(BuildContext context) {
    // utilized to listen for changes and allow
    final provider = context
        .watch<CommunicationProvider>(); // sentence menu to add
    // and remove words at the users choice.
    return Container(
      // a bit of design below with spacing and color.
      padding: EdgeInsets.fromLTRB(
        12,
        12,
        12,
        12,
      ), // left, top, right, and bottom spacing
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white),
              ),
              //
              child:
                  provider
                      .isEmpty // provider to check if sentence menu is
                  ? Text(
                      // empty, if so, it will print a sentence to state menu purpose.
                      'Select images to state words for a sentence',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ) // if not empty, it will call wrap to let the sentence push
                  : Wrap(
                      // to a new line once filled with user selected words.
                      spacing: 6,
                      runSpacing: 4,
                      children: [
                        for (final word
                            in provider.words) // loop to go through each
                          Text(
                            // word in the sentence menu.
                            '$word ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                      ],
                    ),
            ),
          ),
          SizedBox(width: 8), // spacer between speak button and sentence menu.
          GestureDetector(
            // utilized to have speaker button greyed out if nothing is in the
            // sentence menu and will light up to allow user to press once menu is filled.
            // This button will allow the device to speak the sentence menu.
            onTap: provider.isEmpty ? null : provider.speakSentence,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: provider.isEmpty ? Colors.white : Colors.blueAccent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.volume_up_rounded,
                color: provider.isEmpty ? Colors.grey : Colors.white,
                size: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*
This class is utilized to host the board items that are currently supposed to be
on the screen that the user can see along with hosting the display of the layout
of the grid as well. The desired selection of the grid is stored in items variable,
the onTap variable is for normal tap functionality on the screen and onLongPress
is the same but for held presses on the screen. Most of this, again, is mainly
graphical layout of the screen.
 */
class _BoardGrid extends StatelessWidget {
  final List<BoardItemInfo> items;
  final void Function(BoardItemInfo) onTap;
  final void Function(BoardItemInfo) onLongPress;

  const _BoardGrid({
    // constructor of the class
    super.key,
    required this.items,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    // controls the dual tile layout along with the size of each row and individual
    // tile on the screen.
    return GridView.builder(
      padding: EdgeInsets.all(12),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1.20, // specifically utilized for the tile sizes.
      ),
      itemCount: items.length, // creates the individual tile
      itemBuilder: (context, index) {
        final item =
            items[index]; // for the tiles at the specific row locations.
        return _BoardTile(
          item: item,
          onTap: () =>
              onTap(item), // both of these send selection to the screen.
          onLongPress: () => onLongPress(item), // sentence menu
        );
      },
    );
  }
}

/*
This is similar to the last class but is utilized for the creation of the individual
tiles in the grid layout. We have the same variable besides item being one which
is a reference to the indiviudal tiles on the screen. This is majorly layout but
also utilizes a stack for layout of stacking widgets on top of oen another.
 */
class _BoardTile extends StatelessWidget {
  final BoardItemInfo item;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const _BoardTile({
    required this.item,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        decoration: BoxDecoration(
          color: item.color,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(color: Colors.black, blurRadius: 6, offset: Offset(0, 2)),
          ],
        ),
        child: Stack(
          children: [
            // centers and provides the tile icon information for the grid.
            Center(child: Icon(item.image, size: 45, color: item.iconColor)),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  // text portion of the tile with word spoken
                  item.label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            if (item.isCategory) // ui for a category. If a tile is a category,
              Positioned(
                // there will be a white arrow with a blue background
                top: 8, // in the rop right corner indicating that tile leads to
                right:
                    8, // another grid or more detailed tree for similar words.
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.chevron_right_rounded,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

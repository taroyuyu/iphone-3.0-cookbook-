/*
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook, 3.0 Edition
 BSD License, Use at your own risk
 */

#import <UIKit/UIKit.h>

#define COOKBOOK_PURPLE_COLOR	[UIColor colorWithRed:0.20392f green:0.19607f blue:0.61176f alpha:1.0f]
#define BARBUTTON(TITLE, SELECTOR) 	[[[UIBarButtonItem alloc] initWithTitle:TITLE style:UIBarButtonItemStylePlain target:self action:SELECTOR] autorelease]
#define SYSBARBUTTON(ITEM, SELECTOR) [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:ITEM target:self action:SELECTOR] autorelease]
#define MAINLABEL	((UILabel *)self.navigationItem.titleView)

@interface TableListViewController : UITableViewController
@end

@implementation TableListViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView 
{ 
	return 1; 
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section 
{
	return [UIFont familyNames].count;
}

- (UITableViewCell *)tableView:(UITableView *)tView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCellStyle style =  UITableViewCellStyleDefault;
	UITableViewCell *cell = [tView dequeueReusableCellWithIdentifier:@"BaseCell"];
	if (!cell) 
		cell = [[[UITableViewCell alloc] initWithStyle:style reuseIdentifier:@"BaseCell"] autorelease];
	cell.textLabel.text = [[UIFont familyNames] objectAtIndex:indexPath.row];
	cell.selectedBackgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellart.png"]] autorelease];
	
	// This is deprecated but it still works and is available in IB as well
	[cell performSelector:@selector(setSelectedTextColor:) withObject:COOKBOOK_PURPLE_COLOR];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	NSString *font = [[UIFont familyNames] objectAtIndex:indexPath.row];
	[MAINLABEL setText:font];
	[MAINLABEL setFont:[UIFont fontWithName:font size:18.0f]];
}

- (void) loadView
{
	[super loadView];
	self.navigationItem.titleView = [[[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 30.0f)] autorelease];
	[MAINLABEL setBackgroundColor:[UIColor clearColor]];
	[MAINLABEL setTextColor:[UIColor whiteColor]];
	[MAINLABEL setTextAlignment:UITextAlignmentCenter];
}
@end

@interface TestBedAppDelegate : NSObject <UIApplicationDelegate>
@end

@implementation TestBedAppDelegate
- (void)applicationDidFinishLaunching:(UIApplication *)application 
{	
	
	TableListViewController *tlvc = [[TableListViewController alloc] init];
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:tlvc];
	nav.navigationBar.tintColor = COOKBOOK_PURPLE_COLOR;
	
	UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	[window addSubview:nav.view];
	[window makeKeyAndVisible];
}
@end

int main(int argc, char *argv[])
{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	int retVal = UIApplicationMain(argc, argv, nil, @"TestBedAppDelegate");
	[pool release];
	return retVal;
}

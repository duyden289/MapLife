//
//  MSearchAddressViewController.m
//  MapLife
//
//  Created by DenNH on 11/24/16.
//  Copyright © 2016 DenNH. All rights reserved.
//

#import "MSearchAddressViewController.h"

typedef NS_ENUM(NSInteger, MTextFieldType) {
  MTextFieldTypeFromAddress = 0,
  MTextFieldTypeToAddress = 1
};

NSString *const MCurrentAddressName = @"Current Location";
NSString *const MCellAddress = @"CellAddress";

@interface MSearchAddressViewController () <
    UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>

@property(weak, nonatomic) IBOutlet UITextField *textFieldFromAddress;
@property(weak, nonatomic) IBOutlet UITextField *textFieldToAddress;
@property(weak, nonatomic) IBOutlet UITableView *tableAddress;
@property(nonatomic, strong) NSArray<MKMapItem *> *matchingItems;
@property(nonatomic, assign) MTextFieldType textFieldType;
@property(nonatomic, assign)
    CLLocationCoordinate2D locationCoordianteFromAddress;
@property(nonatomic, assign) CLLocationCoordinate2D locationCoordianteToAddress;

@end

@implementation MSearchAddressViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.textFieldToAddress.delegate = self;
  self.textFieldFromAddress.delegate = self;
  self.view.backgroundColor = [UIColor whiteColor];
}
- (IBAction)invokeCancelSearch:(id)sender {
  [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)invokeRoute:(id)sender {

  if (self.delegate &&
      [self.delegate
          respondsToSelector:@selector(searchAddressFromLocationCoordinate:
                                               locationCoordinateToAddress:)]) {
    [self.delegate
        searchAddressFromLocationCoordinate:self.locationCoordianteFromAddress
                locationCoordinateToAddress:self.locationCoordianteToAddress];
  }
  [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark TextFeildDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {

  [self.textFieldFromAddress resignFirstResponder];
  [self.textFieldToAddress resignFirstResponder];
  return YES;
}
- (BOOL)textField:(UITextField *)textField
    shouldChangeCharactersInRange:(NSRange)range
                replacementString:(NSString *)string {

  [self updateSearchResutlForSearchViewController:textField];

  return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
  if (textField == self.textFieldFromAddress) {
    self.textFieldType = MTextFieldTypeFromAddress;
  }

  if (textField == self.textFieldToAddress) {
    self.textFieldType = MTextFieldTypeToAddress;
  }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

  [self.textFieldFromAddress endEditing:YES];
  [self.textFieldToAddress endEditing:YES];
}

- (void)updateSearchResutlForSearchViewController:(UITextField *)textField {

  MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
  request.naturalLanguageQuery = textField.text;
  request.region = self.mapView.region;

  MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
  [search
      startWithCompletionHandler:^(MKLocalSearchResponse *_Nullable response,
                                   NSError *_Nullable error) {
        self.matchingItems = response.mapItems;
        [self.tableAddress reloadData];
      }];
}

#pragma mark TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  return self.matchingItems.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {

  UITableViewCell *cell =
      [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                             reuseIdentifier:MCellAddress];
  MKPlacemark *placeMark = self.matchingItems[indexPath.row].placemark;
  cell.textLabel.text = placeMark.name;
  cell.detailTextLabel.text = [NSString
      stringWithFormat:@"%@, %@, %@", placeMark.name,
                       placeMark.administrativeArea, placeMark.country];
  return cell;
}
- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

  [self.tableAddress deselectRowAtIndexPath:indexPath animated:YES];
  MKPlacemark *placeMark = self.matchingItems[indexPath.row].placemark;
  NSString *fullAddress = [NSString
      stringWithFormat:@"%@, %@, %@", placeMark.name,
                       placeMark.administrativeArea, placeMark.country];

  switch (self.textFieldType) {

  case MTextFieldTypeFromAddress:
    self.textFieldFromAddress.text = fullAddress;
    self.locationCoordianteFromAddress = placeMark.coordinate;
    break;

  case MTextFieldTypeToAddress:
    self.textFieldToAddress.text = fullAddress;
    self.locationCoordianteToAddress = placeMark.coordinate;
    break;

  default:
    break;
  }
}
@end

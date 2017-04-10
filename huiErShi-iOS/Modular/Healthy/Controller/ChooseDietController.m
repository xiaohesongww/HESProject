//
//  ChooseDietController.m
//  huiErShi-iOS
//

//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "ChooseDietController.h"
#import "ChooseNumCell.h"
#import "ChooseDetailCell.h"
#import "ChooseDescriptionCell.h"

static NSString * const reuseIdentifierNum          = @"NumCell";
static NSString * const reuseIdentifierDetail       = @"DetailCell";
static NSString * const reuseIdentifierDescription  = @"DescriptionCell";

@interface ChooseDietController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ChooseDietController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择份数";
    CGRect frame = CGRectMake(0, 0, self.view.bounds.size.height - LayOutW(20), self.view.bounds.size.height);
    self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ChooseNumCell" bundle:nil] forCellReuseIdentifier:reuseIdentifierNum];
    [self.tableView registerNib:[UINib nibWithNibName:@"ChooseDetailCell" bundle:nil] forCellReuseIdentifier:reuseIdentifierDetail];
    [self.tableView registerNib:[UINib nibWithNibName:@"ChooseDescriptionCell" bundle:nil] forCellReuseIdentifier:reuseIdentifierDescription];
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"确认" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarItemPressed)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}

#pragma mark - TableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:{
            ChooseNumCell *chooseNumCell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierNum forIndexPath:indexPath];
            if (!chooseNumCell) {
                chooseNumCell = [[NSBundle mainBundle] loadNibNamed:@"ChooseNumCell" owner:self options:nil].lastObject;
            }
            return chooseNumCell;
        }
            break;
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:{
            ChooseDetailCell *chooseDetailCell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierDetail forIndexPath:indexPath];
            if (!chooseDetailCell) {
                chooseDetailCell = [[NSBundle mainBundle] loadNibNamed:@"ChooseDetailCell" owner:self options:nil].lastObject;
            }
            return chooseDetailCell;
        }
            break;
        case 6:
        case 7:{
            ChooseDescriptionCell *chooseDescriptionCell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierDescription forIndexPath:indexPath];
            if (!chooseDescriptionCell) {
                chooseDescriptionCell = [[NSBundle mainBundle] loadNibNamed:@"ChooseDescriptionCell" owner:self options:nil].lastObject;
            }
            return chooseDescriptionCell;
        }
            break;
            
        default:
            break;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            return LayOutH(88);
            break;
        case 1:
            return LayOutH(60);
            break;
        case 2:
            return LayOutH(60);
            break;
        case 3:
            return LayOutH(60);
            break;
        case 4:
            return LayOutH(60);
            break;
        case 5:
            return LayOutH(60);
            break;
        case 6:
            return LayOutH(120);
            break;
        case 7:
            return LayOutH(120);
            break;
            
            
        default:
            break;
    }
    return 0.1f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *sectionHeaderView = [[UIView alloc] init];
    return sectionHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return LayOutH(360);
}

- (void)rightBarItemPressed {
    
}
@end

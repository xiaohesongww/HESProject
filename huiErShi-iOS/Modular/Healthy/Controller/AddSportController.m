//
//  AddSportController.m
//  huiErShi-iOS
//

//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "AddSportController.h"
#import "AddSportCell.h"
static NSString * const reuseIdentifierText     = @"AddSportCellText";
static NSString * const reuseIdentifierPciker   = @"AddSportCellPicker";

@interface AddSportController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation AddSportController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加运动";
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.view = self.tableView;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"AddSportCell" bundle:nil] forCellReuseIdentifier:reuseIdentifierText];
    [self.tableView registerNib:[UINib nibWithNibName:@"AddSportCell" bundle:nil] forCellReuseIdentifier:reuseIdentifierPciker];
    
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
    NSString *identifier = reuseIdentifierText;
    NSInteger index = 0;
    NSString *placeholder = @"";
//    switch (indexPath.row) {
//        case 3:
//            placeholder = @"组";
//            identifier = reuseIdentifierPciker;
//            index = 1;
//            break;
//        case 4:
//            placeholder = @"个";
//            identifier = reuseIdentifierPciker;
//            index = 1;
//            break;
//        case 6:
//            placeholder = @"请选择";
//            identifier = reuseIdentifierPciker;
//            index = 1;
//            break;
//        case 7:
//            placeholder = @"请选择";
//            identifier = reuseIdentifierPciker;
//            index = 1;
//            break;
//        default:
//            break;
//    }
    AddSportCell *addSportCell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if (!addSportCell) {
        addSportCell = [[[NSBundle mainBundle] loadNibNamed:@"AddSportCell" owner:self options:nil] objectAtIndex:index];
    }
    
    return addSportCell;
}

- (void)rightBarItemPressed {
    
}
@end

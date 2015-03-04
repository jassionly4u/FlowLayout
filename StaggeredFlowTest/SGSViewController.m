//
//  SGSViewController.m
//  StaggeredFlowTest
//
//  Created by PJ Gray on 5/24/13.
//  Copyright (c) 2013 Say Goodnight Software. All rights reserved.
//

#import "SGSViewController.h"
#import "SGSStaggeredFlowLayout.h"
#import "SGSCollectionViewCell.h"

@interface SGSViewController () {
    SGSStaggeredFlowLayout* _flowLayout;
    NSMutableArray* _titles;
}

@end

@implementation SGSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier: @"en_US"];
    NSArray *countryArray = [NSLocale ISOCountryCodes];
    
    NSMutableArray *sortedCountryArray = [[NSMutableArray alloc] init];
    
    for (NSString *countryCode in countryArray) {
        
        NSString *displayNameString = [locale displayNameForKey:NSLocaleCountryCode value:countryCode];
        [sortedCountryArray addObject:displayNameString];
        
    }
    
    
    [sortedCountryArray sortUsingSelector:@selector(localizedCompare:)];

    _titles = [NSMutableArray arrayWithArray:sortedCountryArray];
    
    _flowLayout = [[SGSStaggeredFlowLayout alloc] init];
    _flowLayout.layoutMode = SGSStaggeredFlowLayoutMode_Even;
    _flowLayout.minimumLineSpacing = 5.0f;
    _flowLayout.minimumInteritemSpacing = 5.0f;
    _flowLayout.sectionInset = UIEdgeInsetsMake(20.0f, 10.0f, 10.0f, 10.0f);
    _flowLayout.itemSize = CGSizeMake(100.0f, 40.0f);
    
    self.internalCollectionView.collectionViewLayout = _flowLayout;

    //[self.internalCollectionView registerClass:[SGSCollectionViewCell class] forCellWithReuseIdentifier:@"generic"];
    [self.internalCollectionView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title = _titles[indexPath.row];
    CGSize size = [title sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17.0f]}];
    
    CGSize cellSize;
    CGFloat deviceCellSizeConstant = _flowLayout.itemSize.height;
    cellSize = CGSizeMake(((size.width+10)*deviceCellSizeConstant)/deviceCellSizeConstant, deviceCellSizeConstant);
    
    return cellSize;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    return _titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    SGSCollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"generic" forIndexPath:indexPath];
    
    // load the image for this cell
    
    NSString *title = _titles[indexPath.row];

    cell.contentView.clipsToBounds = YES;

    //[cell.contentView addSubview:imageView];
    [cell.lblTitle setText:title];
    
    return cell;
}

@end

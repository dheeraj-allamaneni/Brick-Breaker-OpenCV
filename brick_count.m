inputfilepath2 = 'L2_clip2_10s.mp4';

obj_vid2 = VideoReader(inputfilepath2);
numFrames2 = 0;
 while hasFrame(obj_vid2)
        readFrame(obj_vid2);
        numFrames2 = numFrames2 + 1;
    end

obj_vid2 = VideoReader(inputfilepath2);

I = read(obj_vid2, 1);

% Starting with Video 2
colorvid2 = zeros([size(I,1) size(I,2) size(I,3) numFrames2], class(I));
% psuedo_frame = zeros([size(I,1) size(I,2) size(I,3) numFrames2], class(I));
outputfilename = 'video1_10s.avi';
frameRatecolorvid2 = get(obj_vid2,'FrameRate');
%     implay(grayvid, frameRategrayvid)
  colorvid2Video = VideoWriter(outputfilename);  
  uncompressedcolorcid2Video = VideoWriter(outputfilename, 'Uncompressed AVI');
  colorvid2Video.FrameRate = frameRatecolorvid2;
  open(colorvid2Video);
  i = 0;
  obj_vid2 = VideoReader(inputfilepath2);

for i = 1:numFrames2
%  while hasFrame(obj_vid2)
single_frame_vid2 = read(obj_vid2, i);
    psuedo_frame = single_frame_vid2;
    psuedo_frame = 0.*single_frame_vid2;
label_single_frame_vid2 = rgb2lab(single_frame_vid2);
ab = label_single_frame_vid2(:,:,2:3);
ab = im2single(ab);
nColors = 15;
% repeat the clustering 3 times to avoid local minima
pixel_labels = imsegkmeans(ab,nColors,'NumAttempts',3);

for kj = 1:nColors
mask_red_vid2{kj} = pixel_labels==kj;%i =3 red 13 kj = 2 white grey kj = 5 multicolumn
mask_red_vid2_erode = imerode(mask_red_vid2{kj}, strel('rectangle',[20 40]));
mask_red_vid2{kj} = imdilate(mask_red_vid2_erode, strel('rectangle',[20 40]));
% imshow(mask_red_vid2{kj})
bw2 = bwdist(mask_red_vid2{kj}) <= 12.5;
% imshow(bw2)
bw2_conn = bwconncomp(bw2);
if bw2_conn.NumObjects >= 3 %get whites 2 columns
    cluster5 = single_frame_vid2 .* uint8(mask_red_vid2{kj});
%     imshow(cluster5)
    ab_white = cluster5(:,:,1);
    ab_white = im2single(ab_white);
    nColors_white = 3;
    % repeat the clustering 3 times to avoid local minima
    pixel_labels_white = imsegkmeans(ab_white,nColors_white,'NumAttempts',3);
%     figure;imshow(pixel_labels_white,[]) 
    
    mask_white = pixel_labels_white==3;
    cluster_white = single_frame_vid2 .* uint8(mask_white);
%     imshow(cluster_white)

    cluster_white_erode1 = imerode(cluster_white, strel('line',20,0));
    cluster_white_dilate1 = imdilate(cluster_white_erode1, strel('line',20,0));
    cluster_white_erode1 = imerode(cluster_white_dilate1, strel('rectangle',[10 20]));
    cluster_white_dilate1 = imdilate(cluster_white_erode1, strel('rectangle',[10 20]));

    bw_cluster_white = im2bw(cluster_white_dilate1);

%     imshow(bw_cluster_white)
    conn_bw_cluster_white = bwconncomp(bw_cluster_white);
    
    bw2_cluster_white = bwdist(bw_cluster_white) <= 12.5;
%     imshow(bw2_cluster_white)

    
    split_white = bwconncomp(bw2_cluster_white);
    L2_cluster_white = labelmatrix(split_white);
    L2_cluster_white(~bw_cluster_white) = 0;

    whiteBlob1 = ismember(L2_cluster_white,1);
    % figure; imshow(whiteBlob1)
    conn_whiteBlob1 = bwconncomp(whiteBlob1);

    whiteBlob2 = ismember(L2_cluster_white,2);
    % figure; imshow(whiteBlob1)
    conn_whiteBlob2 = bwconncomp(whiteBlob2);

    % Number of white bricks in column 1
    %conn_whiteBlob1.NumObjects

    %Getting the centroid of first brick
    centroid_conn_whiteBlob1 = regionprops(conn_whiteBlob1, 'Centroid');

    %Getting the centroid of first brick
    centroid_conn_whiteBlob2 = regionprops(conn_whiteBlob2, 'Centroid');

    ywhite = ceil(centroid_conn_whiteBlob1(1).Centroid(2)) - 60;
    xwhite = ceil(centroid_conn_whiteBlob1(1).Centroid(1))-20;
    position_white = [xwhite ywhite];
    text_str_white = num2str(conn_whiteBlob1.NumObjects);
    box_color = 'red';
    psuedo_frame = insertText(psuedo_frame,position_white,text_str_white,'FontSize',18,'BoxColor',...
        box_color,'BoxOpacity',0.4,'TextColor','white');

    ywhite = ceil(centroid_conn_whiteBlob2(1).Centroid(2)) - 60;
    xwhite = ceil(centroid_conn_whiteBlob2(1).Centroid(1))-20;
    position_white = [xwhite ywhite];
    text_str_white = num2str(conn_whiteBlob2.NumObjects);
    box_color = 'red';
    psuedo_frame = insertText(psuedo_frame,position_white,text_str_white,'FontSize',18,'BoxColor',...
        box_color,'BoxOpacity',0.4,'TextColor','white');


end

if bw2_conn.NumObjects == 2 %get other colors with 2 columns
    cluster5 = single_frame_vid2 .* uint8(mask_red_vid2{kj});

mask_white = mask_red_vid2{kj};
cluster_white = cluster5;
%     cluster_white = single_frame_vid2 .* uint8(mask_white);
%     imshow(cluster_white)

    cluster_white_erode1 = imerode(cluster_white, strel('line',20,0));
    cluster_white_dilate1 = imdilate(cluster_white_erode1, strel('line',20,0));
    cluster_white_erode1 = imerode(cluster_white_dilate1, strel('rectangle',[10 20]));
    cluster_white_dilate1 = imdilate(cluster_white_erode1, strel('rectangle',[10 20]));
%     imshow(cluster_white_dilate1)
    
%     bw_cluster_white = logical(cluster_white_dilate1(:,:,1));
    bw_cluster_white = im2bw(cluster_white_dilate1);
%     bw_cluster_white = im2bw(bw_cluster_white);
%     imshow(bw_cluster_white)
    conn_bw_cluster_white = bwconncomp(bw_cluster_white);
    
    bw2_cluster_white = bwdist(bw_cluster_white) <= 12.5;
%     imshow(bw2_cluster_white)

    
    split_white = bwconncomp(bw2_cluster_white);
    L2_cluster_white = labelmatrix(split_white);
    L2_cluster_white(~bw_cluster_white) = 0;
   
    if split_white.NumObjects == 0
    continue;
    end
    
    whiteBlob1 = ismember(L2_cluster_white,1);
    % figure; imshow(whiteBlob1)
    conn_whiteBlob1 = bwconncomp(whiteBlob1);

    whiteBlob2 = ismember(L2_cluster_white,2);
    % figure; imshow(whiteBlob2)
    conn_whiteBlob2 = bwconncomp(whiteBlob2);

    % Number of white bricks in column 1
    %conn_whiteBlob1.NumObjects

    %Getting the centroid of first brick
    centroid_conn_whiteBlob1 = regionprops(conn_whiteBlob1, 'Centroid');

    %Getting the centroid of first brick
    centroid_conn_whiteBlob2 = regionprops(conn_whiteBlob2, 'Centroid');

    ywhite = ceil(centroid_conn_whiteBlob1(1).Centroid(2)) - 60;
    xwhite = ceil(centroid_conn_whiteBlob1(1).Centroid(1))-20;
    position_white = [xwhite ywhite];
    text_str_white = num2str(conn_whiteBlob1.NumObjects);
    box_color = 'red';
    psuedo_frame = insertText(psuedo_frame,position_white,text_str_white,'FontSize',18,'BoxColor',...
        box_color,'BoxOpacity',0.4,'TextColor','white');
    ywhite = ceil(centroid_conn_whiteBlob2(1).Centroid(2)) - 60;
    xwhite = ceil(centroid_conn_whiteBlob2(1).Centroid(1))-20;
    position_white = [xwhite ywhite];
    text_str_white = num2str(conn_whiteBlob2.NumObjects);
    box_color = 'red';
    psuedo_frame = insertText(psuedo_frame,position_white,text_str_white,'FontSize',18,'BoxColor',...
        box_color,'BoxOpacity',0.4,'TextColor','white');
end

if bw2_conn.NumObjects == 1
   conn_singleBlob = bwconncomp(mask_red_vid2{kj}); 
   centroid_conn_singleBlob = regionprops(conn_singleBlob, 'Centroid');

    ywhite = ceil(centroid_conn_singleBlob(1).Centroid(2)) - 60;
    xwhite = ceil(centroid_conn_singleBlob(1).Centroid(1))-20;
    position_white = [xwhite ywhite];
    text_str_white = num2str(conn_singleBlob.NumObjects);
    box_color = 'red';
    psuedo_frame = insertText(psuedo_frame,position_white,text_str_white,'FontSize',18,'BoxColor',...
        box_color,'BoxOpacity',0.4,'TextColor','white');
end

end
i
altered_frame = psuedo_frame+single_frame_vid2;
        colorvid2(:,:,:,i) = altered_frame;
          writeVideo(colorvid2Video, colorvid2(:,:,:,i));
%2 is white and grey
%3 is red
%4 in blue
%5 is green
%7 is purple
%8 is teal
%9 is orange
%11 is yellow
end
implay(colorvid2, frameRatecolorvid2)
 close(colorvid2Video);

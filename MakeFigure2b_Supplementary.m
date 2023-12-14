function MakeFigure2bb_Supplementary(varargin) 

    addpath(genpath([pwd '/fgtools/']));
    cDir = 'A:\Karen\Figure_2_main\'; 
    inpath=[cDir 'data/']; 
    outpath=[cDir ''];

    % clear all;
    % Example PSTH traces for social and object
    load([inpath 'PSTH_SocObj_Traces_DCN.mat']);
   
    % Spike Trains for raster plots, epochs of interactions
    load([inpath 'Figure_Data_sess18_9.mat']);

    %% Default parameters
    binsize = 0.0334;
    scalor = 0:binsize:420;
    psth_scale = [-115:176]*0.033;

    %% Figure settings 
    fg77 = figure(77);
    clf;
    set(fg77, 'Position', [100 100 900 500]);
    
    DC = axesDivide([1.6 1.6 1.6 1.6],[1.6 1.6 1.6 1.6 ],[0.08 0.08 0.85 0.9], [0.4 0.4 0.3], [0.3 0.6 0.3 ])';
    DC([4, 8, 12]) = [];
    DC{3} = [DC{3}(1)+0.045 DC{3}(2) DC{3}(3)*2 DC{3}(4)];
    DC{6} = [DC{6}(1)+0.045 DC{6}(2)+0.05 DC{6}(3)*2 DC{6}(4)*0.65];
    DC{13} = [DC{13}(1)+0.0375 DC{13}(2)+0.025 DC{13}(3)*0.8 DC{13}(4)*1.75];
    for fgf = 10:12
        DC{fgf} = [DC{fgf}(1) DC{fgf}(2)+0.04 DC{fgf}(3) DC{fgf}(4)*0.7];
    end
    
    Labels = {'A','B','C', '', '', '', 'D','E','F','','','','G'}; LdPos = [-0.02,0.01];
    for i = 1:numel(DC)
        if(~ismember(i, [1, 2, 3, 4, 5, 6]))
            AH(i) = axes('Pos',DC{i}); hold on;     
            % FigLabel(Labels{i},LdPos, 'FontWeight', 'Bold', 'FontSize', 17); 
        end
    end   

% % %     % Spike ratemap and estimates
% % %     sp_t = Spike_Times_All{1}; 
% % %     DN_clu = sp_t(sp_t<420);                                                                        % going over each cluster                                                                   
% % %     DN_bins_temp_norm = histcounts(DN_clu,scalor)./nanmean(histcounts(DN_clu,scalor));
% % %     DN_bins_temp = histcounts(DN_clu,scalor)./binsize;                                              % ./nanmean(histcounts(DN_clu,scalor));
% % %     DN_bins_temp_sm = smooth_gaussian_1d(scalor(1:end-1), DN_bins_temp, 5*binsize);                 % 10*(median(diff(ms_sysClock))));
% % %     Z_score = (DN_bins_temp_sm-nanmean(DN_bins_temp_sm))./std(DN_bins_temp_sm);
% % % 
% % %     [theta_sig_z] = motif_triggered_theta(epochs_object(:, 1)*1000, Z_score, scalor*1000, 87, 176); %, 87, 133); 
% % %     % theta_sig_z_socc(1, 29:end) = theta_sig_z(1, :);

% % %     axes(AH(3));
% % %     hold off;
% % %     plotcol = 'r';
% % %     temp = Spike_Times_All{1}; % _Social
    scale = [-115:176]*0.033; % -4:0.0125:6;
% % %     Mat_ii = nan(size(epochs_object, 1), length(scale)-1);
% % %     for ii = 1:size(epochs_object, 1)
% % %         temp_ii = temp-epochs_object(ii, 1);
% % %         Mat_ii(ii, :) = smooth_gaussian_1d(scale(1:end-1), histcounts(temp_ii, scale), mean(diff(scale))*5);
% % %     end
% % %     hold off;   
% % %     theta_sig_z_objj(size(epochs_object, 1)+1, :) = zeros(1, length(scale));   
% % %     pcolor(scale(1:end), 0.5:size(epochs_object, 1)+0.5, theta_sig_z_objj);
% % %     shading flat; 
% % %     hold on;  
% % %     xlim([-4 6]);
% % %     cb1 = colorbar('northoutside');
% % %     set(cb1, 'Position', [0.6 0.75 0.05 0.01]);
% % %     caxis([-2.75 2.75]);   
% % %     set(gca,'color','none');  
% % %     ylim([0.5 10.5]);
% % %     set(gca, 'TickDir', 'out', 'Box', 'off', 'FontSize', 13);
% % %     set(gca, 'YTick', [1 10]);
% % %     set(gca,'TickLength', [0.01 0.025]*1.5);   
% % %     ylabel('Epochs (#)', 'FontSize', 12, 'FontWeight', 'Normal');
% % %     AH(3).XAxis.Visible = 'off';                                            
% % %     % FigLabel(Labels{3}, [-0.05, 0.01], 'FontWeight', 'Bold');  
% % %     text(min(get(gca, 'xlim'))-0.175*diff((get(gca, 'xlim'))), max(get(gca, 'ylim'))+0.025*diff((get(gca, 'ylim'))), 'C', 'FontSize', 14, 'FontWeight', 'Bold');
    
    %%
% % %     axes(AH(6));
% % %     hold off;
% % %     shadedErrorBar([-115:176]*0.033, nanmean(theta_sig_z_objj), nanstd(theta_sig_z_objj)./sqrt(size(theta_sig_z_objj, 1)), {'color', [87 87 86]./255}, 0.1); % 
% % %     hold on;
% % %     ylim([-2.75 2.75]);
% % %     xlim([min([-115:176]*0.033) max([-115:176]*0.033)]);
% % %     xlim([-4 6]);
% % %     plot([0 0], [-2.75 14], '--', 'color', [0.7 0.7 0.7], 'LineWidth', 2); 
% % %     plot(get(gca, 'XLim'), [0 0], '-', 'color', [0 0 0], 'LineWidth', 0.5);
% % %     set(gca,'color','none');  
% % %     set(gca, 'YTick', [-2 0 2]);
% % %     set(gca, 'XTick', [-4:2:6]);
% % %     set(gca, 'TickDir', 'out', 'Box', 'off', 'FontSize', 13);
% % %     set(gca,'TickLength', [0.01 0.025]*1.5);
% % %     ylabel('Rate (Z-score)', 'FontSize', 12, 'FontWeight', 'Normal');
% % %     xlabel('Object Interaction Onset (sec.)', 'FontSize', 12, 'FontWeight', 'Normal');
% % %     AH(6).Clipping = 'off';    
    
        
    %%    
    load([inpath 'Combined_Dataset.mat']);
    alpha = 0.05;
    v1_Mutual = alpha>soc_DN_alll_AUC1_Mutual & ~Purkinje_ID_alll_Mutual;
    v2_Mutual = alpha>soc_DN_alll_AUC2_Mutual & ~Purkinje_ID_alll_Mutual;
    v3_Mutual = alpha>soc_DN_alll_AUC1_Mutual & Purkinje_ID_alll_Mutual;
    v4_Mutual = alpha>soc_DN_alll_AUC2_Mutual & Purkinje_ID_alll_Mutual;

    v1_Object = alpha>soc_DN_alll_AUC1_Object & ~Purkinje_ID_alll_Object;
    v2_Object = alpha>soc_DN_alll_AUC2_Object & ~Purkinje_ID_alll_Object;
    v3_Object = alpha>soc_DN_alll_AUC1_Object & Purkinje_ID_alll_Object;
    v4_Object = alpha>soc_DN_alll_AUC2_Object & Purkinje_ID_alll_Object;
    
    %% Purkinje Object Positive
    % Heatmap    
    axes(AH(7)); 
    hold off;
    postt = psth_scale>0.75 & psth_scale<1.25;
    pre = psth_scale>-2.25 & psth_scale<-1.75;
    [~, ind] = sort(nanmean(ZRateMap_SocPSTH_alll_Object(~Purkinje_ID_alll_Object & v1_Object, postt), 2));   
    Purk_psth_neg_all = ZRateMap_SocPSTH_alll_Object(~Purkinje_ID_alll_Object & v1_Object, :);
    pcolor(psth_scale, 1:size(Purk_psth_neg_all, 1)+1, [Purk_psth_neg_all(ind, :); zeros(1, length(scale))]);
    shading flat;
    hold on;  
    xlim([-4 6]);
    ylim([0.5 size(Purk_psth_neg_all, 1)+4.5])
    cb1 = colorbar('northoutside');
    set(cb1, 'Position', [0.35 0.2 0.05 0.01]);
    caxis([-1 1]);
    cb1.Visible = 'off';
    set(gca,'color','none');
    set(gca, 'TickDir', 'out', 'Box', 'off', 'FontSize', 13);
    set(gca,'TickLength', [0.01 0.025]*2.5);
    set(gca, 'YTick', [1.5:2:size(Purk_psth_neg_all, 1)+4.5], 'YTickLabel', [1:2:size(Purk_psth_neg_all, 1)+4]);
    ylabel('Purkinje (id)', 'FontSize', 12, 'FontWeight', 'Normal');
    AH(7).XAxis.Visible = 'off'; 
    AH(7).YDir = 'reverse';  
    text(min(get(gca, 'xlim'))-0.25*diff((get(gca, 'xlim'))), min(get(gca, 'ylim'))-0.1*diff((get(gca, 'ylim'))), 'A', 'FontSize', 14, 'FontWeight', 'Bold');

    axes(AH(10));
    hold off;
    plot(-10, 1, 'color', [155 38 22]./255);
    hold on;
    shadedErrorBar(psth_scale, nanmean(ZRateMap_SocPSTH_alll_Object(v1_Object, :)),...
        nanstd(ZRateMap_SocPSTH_alll_Object(v1_Object, :))./sqrt(sum(v1_Object)), {'color', [155 38 22]./255}, 0.1);
    xlim([-115*0.03 176*0.03]);
    ylim([-2.25 1.75]);
    set(gca, 'TickDir', 'out');
    AH(10).XColor = [155 38 22]./255;
    AH(10).YColor = [155 38 22]./255;
    set(gca,'TickLength', [0.01 0.025]*3);
    plot([0 0], [min(get(gca, 'YLim')) 5.25*max(get(gca, 'YLim'))], '--', 'color', [0.7 0.7 0.7], 'LineWidth', 2);
    plot(get(gca, 'XLim'), [0 0], '-',  'color', [0 0 0],'LineWidth', 0.5);
    set(gca, 'TickDir', 'out', 'FontSize', 13); 
    ylabel('Rate (Z-score)', 'FontSize', 12, 'FontWeight', 'Normal', 'color', 'k');
    AH(10).Clipping = 'off';   
    
    %% Purkinje cell antiSocial
    % Heatmap
    psth_scale = [-115:176]*0.033;  
    axes(AH(8));
    hold off;
    postt = psth_scale>0.75 & psth_scale<1.25;
    pre = psth_scale>-2.25 & psth_scale<-1.75;
    [~, ind] = sort(nanmean(ZRateMap_SocPSTH_alll_Object(~Purkinje_ID_alll_Object & v2_Object, postt), 2));
    Purk_psth_neg_all = ZRateMap_SocPSTH_alll_Object(~Purkinje_ID_alll_Object & v2_Object, :);
    P_image = [Purk_psth_neg_all(ind, :); nan(1, size(Purk_psth_neg_all(ind, :), 2))];
    pcolor(psth_scale, 1:size(P_image, 1), P_image);
    shading  flat; 
    hold on;
    plot([0 0], [0 sum(v4_Object)], '--', 'color', [0.7 0.7 0.7], 'LineWidth', 2); 
    xlim([-4 6]);
    ylim([0 sum(~all(isnan(P_image')))+4.5]);
    cb1 = colorbar('northoutside');  
    set(cb1, 'Position', [0.2 0.3125 0.05 0.01]);
    caxis([-1 1]);
    set(gca,'color','none');
    set(gca, 'TickDir', 'out', 'Box', 'off', 'FontSize', 13);
    set(gca, 'YTick', [1.5:2:sum(~all(isnan(P_image')))+4.5], 'YTickLabel', [1:2:sum(~all(isnan(P_image')))+4]);
    set(gca,'TickLength', [0.01 0.025]*2.5);
    AH(8).XAxis.Visible = 'off'; 
    AH(8).YDir = 'reverse';
    text(min(get(gca, 'xlim'))-0.2*diff((get(gca, 'xlim'))), min(get(gca, 'ylim'))-0.1*diff((get(gca, 'ylim'))), 'B', 'FontSize', 14, 'FontWeight', 'Bold');
  
    axes(AH(11));
    hold off;
    plot(-10, 1, 'color', [231 75 53]./255);
    hold on;
    shadedErrorBar(psth_scale, nanmean(ZRateMap_SocPSTH_alll_Object(v2_Object, :)),...
        nanstd(ZRateMap_SocPSTH_alll_Object(v2_Object, :))./sqrt(sum(v2_Object)), {'color', [231 75 53]./255}, 0.1);
    xlim([-115*0.03 176*0.03]);
    ylim([-2.25 1.75]);
    set(gca, 'TickDir', 'out');
    AH(11).XColor = [231 75 53]./255;
    AH(11).YColor = [231 75 53]./255;
    set(gca,'TickLength', [0.01 0.025]*3);
    plot([0 0], [min(get(gca, 'YLim')) 5.25*max(get(gca, 'YLim'))], '--', 'color', [0.7 0.7 0.7], 'LineWidth', 2);
    plot(get(gca, 'XLim'), [0 0], '-',  'color', [0 0 0],'LineWidth', 0.5);
    set(gca, 'TickDir', 'out', 'FontSize', 13);
    xlabel('Object Interaction Onset (sec.)', 'FontSize', 12, 'FontWeight', 'Normal');
    AH(11).Clipping = 'off';  
    
    
    %% The rest of them
    % Heatmap
    axes(AH(9));
    hold off;
    postt = psth_scale>0.75 & psth_scale<1.25;
    pre = psth_scale>-2.25 & psth_scale<-1.75;
    [~, ind] = sort(nanmean(ZRateMap_SocPSTH_alll_Object(~Purkinje_ID_alll_Object & ~v2_Object & ~v1_Object, postt), 2));
    Purk_psth_neg_all = ZRateMap_SocPSTH_alll_Object(~Purkinje_ID_alll_Object & ~v2_Object & ~v1_Object, :);
    P_image = [Purk_psth_neg_all(ind, :); nan(1, size(Purk_psth_neg_all(ind, :), 2))];
    pcolor(psth_scale, 1:size(P_image, 1), P_image);
    shading  flat;  
    hold on;
    xlim([-4 6]);
    ylim([0 sum(~all(isnan(P_image')))+4.5]);
    cb1 = colorbar('northoutside');    
    set(cb1, 'Position', [0.35 0.565 0.05 0.01]);
    caxis([-1 1]);
    cb1.Visible = 'off';
    set(gca,'color','none');
    set(gca, 'TickDir', 'out', 'Box', 'off', 'FontSize', 13);
    set(gca, 'YTick', [1.5:7:sum(~all(isnan(P_image')))+4.5], 'YTickLabel', [1:7:sum(~all(isnan(P_image')))+4.5]);
    set(gca,'TickLength', [0.01 0.025]*2.5);   
    LdPos = [-0.02,0.01];  
    AH(9).XAxis.Visible = 'off'; 
    AH(9).YDir = 'reverse';
    % FigLabel(Labels{12}, [0.0001,0.025], 'FontWeight', 'Bold');  
    text(min(get(gca, 'xlim'))-0.25*diff((get(gca, 'xlim'))), min(get(gca, 'ylim'))-0.1*diff((get(gca, 'ylim'))), 'C', 'FontSize', 14, 'FontWeight', 'Bold');
     
    axes(AH(12));
    hold off;
    plot(-10, 1, 'color', [231 75 53]./255);
    hold on;
    shadedErrorBar(psth_scale, nanmean(ZRateMap_SocPSTH_alll_Object(~Purkinje_ID_alll_Object & ~v2_Object & ~v1_Object, :)),...
        nanstd(ZRateMap_SocPSTH_alll_Object(~Purkinje_ID_alll_Object & ~v2_Object & ~v1_Object, :))./sqrt(sum(~Purkinje_ID_alll_Object & ~v2_Object & ~v1_Object)), {'color', [244 155 127]./255}, 0.1);
    xlim([-115*0.03 176*0.03]);
    ylim([-2.25 1.75]);
    set(gca, 'TickDir', 'out');
    AH(12).XColor = [244 155 127]./255;
    AH(12).YColor = [244 155 127]./255;
    set(gca,'TickLength', [0.01 0.025]*3);
    plot([0 0], [min(get(gca, 'YLim')) 5.25*max(get(gca, 'YLim'))], '--', 'color', [0.7 0.7 0.7], 'LineWidth', 2);
    plot(get(gca, 'XLim'), [0 0], '-',  'color', [0 0 0],'LineWidth', 0.5);
    set(gca, 'TickDir', 'out', 'FontSize', 13);  
    AH(12).Clipping = 'off';    
    
    axes(AH(13));
    hold off;
    br = bar(([sum(v1_Object) sum(v2_Object) sum(~v1_Object & ~v2_Object & ~Purkinje_ID_alll_Object)]/sum(~Purkinje_ID_alll_Object))*100);
    br.FaceColor = 'flat';
    br.CData(1, :) = [155 38 22]./255;
    br.CData(2, :) = [231 75 53]./255;
    br.CData(3, :) = [244 155 127]./255;
    br.EdgeColor = 'none';
    br.BarWidth = 0.9;
    ylim([0 70]);
    set(gca, 'TickDir', 'out');
    set(gca,'TickLength', [0.01 0.025]*5);
    set(gca, 'Xtick', [1 2 3], 'XtickLabel', {'Soc^{+}', 'Soc^{-}', 'Other'} );
    set(gca, 'FontSize', 11, 'FontWeight', 'Normal', 'Box', 'off');
    ylabel('Singnificant Units (%)', 'FontSize', 11, 'FontWeight', 'Normal');
    xtickangle(45);
%     FigLabel(Labels{13}, [-0.05, 0.01], 'FontWeight', 'Bold');   
    text(min(get(gca, 'xlim'))-0.275*diff((get(gca, 'xlim'))), max(get(gca, 'ylim'))+0.1*diff((get(gca, 'ylim'))), 'D', 'FontSize', 14, 'FontWeight', 'Bold');

    
    direc_sv = 'A:\Karen\Figure_1_main_Supplementary';
    outfile = fullfile(direc_sv, sprintf('SUPPLEMENTARY_FIGURE_1_DCN_Object'));
    set(fg77, 'paperunits', 'inches', 'paperposition', [1.5 1.5   14.9 10.9]); 
    print(fg77, outfile, '-djpeg', '-r600');
    print(fg77, outfile, '-dtiff', '-r600'); 
    
    
end

